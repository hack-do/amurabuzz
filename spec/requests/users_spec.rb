# require 'rails_helper'

# describe "devise/session/new.html.erb", :type => :request,js: true do
  

#   before :each do
#   	include Devise::TestHelpers
#     Warden.test_mode!
#     @user = FactoryGirl.build(:user)
#     @request.env["devise.mapping"] = Devise.mappings[@user]
#     @user.confirm!
#     sign_in @user
#     # login_as @user,:scope => :user
#     # @user.confirmed_at = Time.now
#     # @user.save
#     puts "#{@user.inspect}"

#     visit my_user_path('me')
#     puts "Current Path : #{current_path}"
#   end

#   it "shows correct followers,following and tweets" do
   
#     Capybara.default_selector = :xpath

#     expect(find(:id,'user_followers_count').text.to_i).to eq(@user.followers.count)
#     expect(find(:id,'user_following_count').text.to_i).to eq(@user.following.count)
#     expect(find(:id,'user_tweets_count').text.to_i).to eq(@user.tweets.count)
    
#   end

# end