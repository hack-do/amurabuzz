class ChatsController < ApplicationController
	before_action :check_login
  	
  	
  	def create  
      message = Twemoji.parse(params[:message])
      recipient = User.where(id: params[:recipient_id]).first

      if message.present? && recipient.present?
        flag = publish_message(recipient,message)
      end

    	respond_to do |format|
      		if flag == 1
        		format.html { redirect_to :back }
            format.json { render json: {message: 'yay'} }
      		else
            format.html { redirect_to :back }
        		format.json { render json: {message: 'ohh'}, status: :unprocessable_entity }
      		end
    	end
  	end

    def publish_message(recipient,message)
        PrivatePub.publish_to "/chats/#{recipient.id}", user_id: current_user.id,user_name: current_user.user_name,recipient_id: recipient.id,recipient_name: recipient.name, message: message
        PrivatePub.publish_to "/chats/#{current_user.id}", user_id: current_user.id, user_name: current_user.user_name,recipient_id: recipient.id,recipient_name: recipient.name, message: message
        1
    end
end
