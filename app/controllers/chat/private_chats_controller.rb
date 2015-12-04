class Chat::PrivateChatsController < ApplicationController
  include Tubesock::Hijack

  before_action :check_login

  def index
  end

  def chat
    puts "params #{params}"

    @@redis = Redis.new
    if @@redis.hmget("users", current_user.id.to_s).present?
      # return
      # raise StandardError, "User Id #{current_user.id} already online"
    end

    hijack do |tubesock|
      # initialize - Listen on its own thread
      puts "hijack started"
      redis_thread = Thread.new do
        puts "new thread created"
        @@redis.hset("users", current_user.id.to_s, current_user.user_name)

        # Needs its own redis connection to pub
        # and sub at the same time
        @@redis.subscribe "chat-#{params[:user_id]}" do |on|
          puts "Subscribe to Redis channel"
          on.message do |channel, message|
            puts "message sent #{message}"
            tubesock.send_data message
          end
        end
      end # initialize

      tubesock.onmessage do |params|
        @@redis = Redis.new
        # pub the message when we get one
        # note: this echoes through the sub above
        params = JSON.parse(params)

        sender_name = @@redis.hget("users",params["sender_id"])
        if sender_name.blank?
          sender_name = User.find(params["sender_id"]).user_name
        end

        recipient_name = @@redis.hget("users",params["recipient_id"])
        if recipient_name.blank?
          recipient_name = User.find(params["recipient_id"]).user_name
        end

        if recipient_name.present? && sender_name.present?
          params["sender_name"] = sender_name
          params["recipient_name"] = recipient_name
          params["message"] = parse_message(params["message"])

          puts "message received #{params}"

          @@redis.publish "chat-#{params['sender_id']}", params.to_json
          @@redis.publish "chat-#{params['recipient_id']}", params.to_json
        else
          raise StandardError, "Invalid Sender id #{params['sender_id']} or Recipient id #{params['recipient_id']}"
        end
      end # onmessage

      tubesock.onclose do
        puts "onclose"

        @@redis = Redis.new
        @@redis.hdel("users",current_user.id.to_s)

        # stop listening when client leaves
        redis_thread.kill
      end # onclose
    end
  end # def

  def send_message
    errors = []
    if params[:message].present?
      message = Twemoji.parse(params[:message])
    else
      errors << ["Message not present"]
    end

    if params[:recipient_id].present?
      recipient = User.where(id: params[:recipient_id]).first
    else
      errors << ["Recipient not present"]
    end

    respond_to do |format|
		  if errors.blank?
        publish_message(current_user, recipient,message)
        format.html { redirect_to :back }
        format.json { render json: {message: 'yay'} }
      else
        format.html { redirect_to :back }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
	end

  private

  def publish_message(sender, recipient, message)
    channels = [get_private_channel(recipient.id.to_s), get_private_channel(sender.id.to_s)]

    channels.each do |channel|
      PrivatePub.publish_to(channel,
        sender_id: sender.id,
        sender_name: sender.user_name,
        recipient_id: recipient.id,
        recipient_name: recipient.name,
        message: message
      )
    end
  end

  def parse_message(message)
    Twemoji.parse(message)
  end

  def get_private_channel(user_id)
    "/chats/#{user_id}"
  end

  def get_public_channel
    "/chats/public"
  end
end
