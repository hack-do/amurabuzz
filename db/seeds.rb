require 'faker'

u1 = User.create!(name: 'Vineet Ahirkar',email: "vineet@amuratech.com",password: "amura123",user_name: "vinzee", :password_confirmation => "amura123")
u2 = User.create!(name: 'Sayali Pendharkar', email: "sayali@amuratech.com",password: "amura123",user_name: "say", :password_confirmation => "amura123")
u3 = User.create!(name: 'Shaunak Pagnis',email: "shaunak@amuratech.com",password: "amura123",user_name: "shaun", :password_confirmation => "amura123")

20.times do |i|
	t1 = Tweet.create!(content: Faker::Lorem.characters(160),user_id: u1.id)
	t2 = Tweet.create!(content: Faker::Lorem.characters(160),user_id: u2.id)
	t3 = Tweet.create!(content: Faker::Lorem.characters(160),user_id: u3.id)
end