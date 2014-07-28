# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	u1 = User.create(email: "vineet@amuratech.com",password: "qwerty007",user_name: "vinzeee", :password_confirmation => "qwerty007")
	User.create(email: "vinzee93@gmail.com",password: "qwerty007",user_name: "vinzee", :password_confirmation => "qwerty007")
	User.create(email: "sayali@amuratech.com",password: "sayali123",user_name: "sayali912", :password_confirmation => "sayali123")
	User.create(email: "shaunak@amuratech.com",password: "12345678",user_name: "12345678", :password_confirmation => "qwerty007")


	# 50.times do |i|
	# 	u1.tweets = u1.tweets << Tweet.create(content: "Tweet #{i}")
	# end

		u1.tweets = u1.tweets << Tweet.create(content: "Tweet")

		u1.tweets = u1.tweets << Tweet.create(content: "Tweet")

		u1.tweets = u1.tweets << Tweet.create(content: "Tweet")

		u1.tweets = u1.tweets << Tweet.create(content: "Tweet")

		u1.tweets = u1.tweets << Tweet.create(content: "Tweet")
		
		u1.tweets = u1.tweets << Tweet.create(content: "Tweet")