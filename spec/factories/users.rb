# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
  	 name 		Faker::Name.name #'Vineet Ahirkar'
  	 user_name  Faker::Internet.user_name #'vinzee'
  	 email  	Faker::Internet.safe_email #'vinzee@gmail.com'
  	 password	Faker::Internet.password(8, 128) #'qwerty007'
  	 dob 		Faker::Business.credit_card_expiry_date #'Time.now - 20.years'
  end

  factory :user1,class: User do
     name     Faker::Name.name #'Vineet Ahirkar'
     user_name  Faker::Internet.user_name #'vinzee'
     email    Faker::Internet.safe_email #'vinzee@gmail.com'
     password Faker::Internet.password(8, 128) #'qwerty007'
     dob    Faker::Business.credit_card_expiry_date #'Time.now - 20.years'
  end

 factory :user2,class: User do
     name     'Vineet Ahirkar'
     user_name  'vinzee'
     email    'vinzee@gmail.com'
     password 'qwerty007'
     dob    Time.now - 20.years
  end
end
