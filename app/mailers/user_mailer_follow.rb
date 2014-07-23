class UserMailerFollow < ActionMailer::Base
<<<<<<< HEAD
	 #include Resque::Mailer
=======
	 include Resque::Mailer
>>>>>>> 25a213bf745824af8a35ea8ccd8a92cff48c8f2e
	#self.async = true
	default :from => "amurabuzz@gmail.com"
  def new_follower(usermail,follower)
  	@follower = follower
  	mail(:to => "#{usermail}", :subject => "New Follower #{follower.user_name}")
  end
<<<<<<< HEAD
  	handle_asynchronously :new_follower,:deliver
=======
>>>>>>> 25a213bf745824af8a35ea8ccd8a92cff48c8f2e
end
