require 'faker'

u = User.new(name: 'Vineet Ahirkar', email: "vineet@amuratech.com", user_name: "vinzee", password: "amura123", :password_confirmation => "amura123")
u.skip_confirmation!
u.save
u = User.new(name: 'Sayali Pendharkar',  email: "sayali@amuratech.com", user_name: "say", password: "amura123", :password_confirmation => "amura123")
u.skip_confirmation!
u.save
u = User.new(name: 'Shaunak Pagnis', email: "shaunak@amuratech.com", user_name: "shaun", password: "amura123", :password_confirmation => "amura123")
u.skip_confirmation!
u.save
u = User.new(name: 'Tanmay Patil', email: "tanmay@amuratech.com", user_name: "tan", password: "amura123", :password_confirmation => "amura123")
u.skip_confirmation!
u.save
u = User.new(name: 'Vrushali Waykole',  email: "vrushali@amuratech.com", user_name: "vru", password: "amura123", :password_confirmation => "amura123")
u.skip_confirmation!
u.save

User.all.each do |user|
	User.all.each do |user1|
		user.follow(user1.id) if user != user1
	end
end

10.times do |n|
	password = Faker::Internet.password
	User.create!(name: Faker::Name.name,email: Faker::Internet.email,user_name: Faker::Internet.user_name,password: password) # , :password_confirmation => password
end

User.all.each do |u|
	20.times do |i|
		Tweet.create!(content: Faker::Lorem.characters(160),user_id: u.id)
	end
end