require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @user = FactoryGirl.create :user
    @user1 = FactoryGirl.create :user
  end

  it "gets created and is associated to a user" do
  	@user.follow(@user1.id)
  	expect(@user.following.count).to eq 1
  	expect(@user1.followers.count).to eq 1
  end
end
