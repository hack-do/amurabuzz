# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
  	 name { Faker::Name.name } 
  	 user_name{ Faker::Internet.user_name } 
  	 email { Faker::Internet.safe_email } 
  	 password { Faker::Internet.password(8, 128) } 
  	 dob { Faker::Time.between(40.years.ago, Time.now) } 
     confirmed_at { Time.now }
  end
end
