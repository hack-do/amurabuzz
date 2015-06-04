class ChatsController < ApplicationController
    before_action :check_login
  	
    def init
        @friends = current_user.friends
        respond_to do |format|
           format.json { render json: @friends }
        end
    end

  	def create  
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
                publish_message(recipient,message)
        
        		format.html { redirect_to :back }
                format.json { render json: {message: 'yay'} }
      		else
                format.html { redirect_to :back }
        		format.json { render json: errors, status: :unprocessable_entity }
      		end
    	end
  	end


    private

    def publish_message(recipient,message)
        PrivatePub.publish_to "/chats/#{recipient.id}", user_id: current_user.id,user_name: current_user.user_name,recipient_id: recipient.id,recipient_name: recipient.name, message: message
        PrivatePub.publish_to "/chats/#{current_user.id}", user_id: current_user.id, user_name: current_user.user_name,recipient_id: recipient.id,recipient_name: recipient.name, message: message
    end
end