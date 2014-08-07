# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
  	content Faker::Lorem.characters(100)
  	association :user
  end
end
