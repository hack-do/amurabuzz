class UserMailerFollow < ActionMailer::Base

	default :from => "amurabuzz@gmail.com"
  	def new_follower(usermail,follower)
  		@follower = follower
  		mail(to: "#{usermail}",subject: "New Follower #{follower.user_name}",content_type: "multipart/alternative")
  	end
end
