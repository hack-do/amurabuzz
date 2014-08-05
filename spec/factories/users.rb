# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
   factory :user do
   	id 			Faker::Number.digit
    name        Faker::Name.name
    user_name   Faker::Internet.user_name
    email       Faker::Internet.email
    password    Faker::Internet.password
  end
end
