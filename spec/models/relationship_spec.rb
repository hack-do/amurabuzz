require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
	  @user = User.create(user_name: "vinzee",password: "12121212",email: "vinzee93@gmail.com")
	  @tweet = Tweet.create(content: "Tweet 1")
	  @user.tweets << @tweet
	  @user.save
  end

  it "gets created and is associated to a user" do
  	expect(@user.tweets.count).to eq 1
  end

end
