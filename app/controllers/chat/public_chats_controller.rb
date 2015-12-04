class Chat::PublicChatsController < ApplicationController
  include Tubesock::Hijack

  before_action :check_login

  def index
  end

  def chat
    hijack do |tubesock|
      # Listen on its own thread
      redis_thread = Thread.new do
        # Needs its own redis connection to pub
        # and sub at the same time
        Redis.new.subscribe "chat" do |on|
          on.message do |channel, message|
            puts "message to be sent #{message}"
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |params|
        # pub the message when we get one
        # note: this echoes through the sub above
        params = JSON.parse(params)
        params["message"] = Twemoji.parse(params["message"])
        puts "message received  #{params}"
        Redis.new.publish "chat", params.to_json
      end

      tubesock.onclose do
        # stop listening when client leaves
        redis_thread.kill
      end
    end
  end

end
