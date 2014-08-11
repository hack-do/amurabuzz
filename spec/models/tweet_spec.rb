require 'rails_helper'

RSpec.describe Tweet, :type => :model do

  before(:each) do
	@tweet = FactoryGirl.create :tweet
	@user = @tweet.user
	puts "----------Tweet : #{@tweet.inspect}-------"
  end

  	it "creates valid tweet successfully" do 
  		expect(@tweet).to be_valid
  		expect(@user.tweets.count).to eq(1)
	end  

	it "invalidates bigger tweet(200 characters)" do
		@tweet.content  = Faker::Lorem.characters(200)
		expect(@tweet).not_to be_valid
	end

	it "gets paranoid deleted successfully" do 
		@tweet.destroy
		expect(@tweet.deleted_at).not_to be_nil
	end

	it "gets really deleted successfully" do
		@tweet.really_destroy!
		expect {Tweet.find(@tweet.id)}.to raise_error ActiveRecord::RecordNotFound
	end



end
