# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	User.create(email: "vineet@amuratech.com",password: "qwerty007",user_name: "vinzeee", :password_confirmation => "qwerty007")
	User.create(email: "shaunak.pagnis@gmail.com",password: "12345678",user_name: "shaunakp", :password_confirmation => "12345678")
	User.create(email: "sayali@amuratech.com",password: "sayali123",user_name: "sayali912", :password_confirmation => "sayali123")
	User.create(email: "shaunak@amuratech.com",password: "12345678",user_name: "shaunakpp", :password_confirmation => "12345678")

	50.times do |i|
		t = Tweet.create!(content: "Tweet #{i}",user_id: "1")
	end

	50.times do |i|
		t = Tweet.create!(content: "Tweet #{i}",user_id: "2")
	end

	50.times do |i|
		t = Tweet.create!(content: "Tweet #{i}",user_id: "4")
	end

	50.times do |i|
		t = Tweet.create!(content: "Tweet #{i}",user_id: "3")
	end