class UserMailerFollow < ActionMailer::Base
	#include Resque::Mailer
	default :from => "amurabuzz@gmail.com"
  def new_follower(usermail,follower)
  	@follower = follower
  	mail(:to => "#{usermail}", :subject => "New Follower #{follower.user_name}")
  end
  handle_asynchronously :new_follower
end
