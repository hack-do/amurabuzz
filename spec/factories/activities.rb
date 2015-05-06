# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :activity do
  	
		trackable_id   Faker::Number.digit
		trackable_type nil
		owner_id       Faker::Number.digit
		owner_type     nil
		key            nil
		parameters     {nil}
		recipient_id	Faker::Number.digit
		recipient_type nil

  end
end
