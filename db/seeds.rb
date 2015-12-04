require 'faker'

user_params = [
	{name: 'Vineet Ahirkar', email: "vineet@amuratech.com", user_name: "vinee da pooh", password: "amura123"},
	{name: 'Sayali Pendharkar',  email: "sayali@amuratech.com", user_name: "sayee duck", password: "amura123"},
	{name: 'Shaunak Pagnis', email: "shaunak@amuratech.com", user_name: "shaun da don", password: "amura123"},
	{name: 'Tanmay Patil', email: "tanmay@amuratech.com", user_name: "tan da man", password: "amura123"},
	{name: 'Vrushali Waykole',  email: "vrushali@amuratech.com", user_name: "vru", password: "amura123"}
]

user_params.each do |params|
	params[:bio] = Faker::Lorem.sentence(rand(1..4))
	# params[:dob] = Faker::Lorem.sentence(rand(1..4))
	u = User.create!(params)
	u.pictures.create!(image_type: 'profile_picture', folder: 'Profile Pictures',file: File.open("#{Rails.root}/app/assets/images/amura.png"))
	u.skip_confirmation!
end

puts "Basic users created"

User.all.each do |user|
	User.all.each do |user1|
		user.follow(user1.id) if user != user1
	end
end

puts "Basic user relationships created"

10.times do |n|
	u = User.create!(name: Faker::Name.name,email: Faker::Internet.email,user_name: Faker::Internet.user_name,password: Faker::Internet.password, bio: Faker::Lorem.sentence(rand(1..4)))
	u.pictures.create!(image_type: 'profile_picture', folder: 'Profile Pictures',file: File.open("#{Rails.root}/app/assets/images/amura.png"))

end
puts "Additional users created"

User.all.each do |u|
	20.times do |i|
		Tweet.create!(content: Faker::Lorem.sentence(rand(1..4)),user_id: u.id)
	end
end
puts "Tweets created"
