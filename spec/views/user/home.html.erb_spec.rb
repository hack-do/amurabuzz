require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do
  
  before :each do
    Warden.test_mode!
    @user = FactoryGirl.build(:user)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    #@user.confirm!
    #sign_in @user
    @user.confirmed_at = Time.now
    @user.save
    login_as @user,:scope => :user
    puts "#{@user.inspect}"

    visit my_home_path('me')
    puts "Current Path : #{current_path}"
  end

  it "shows correct followers,following and tweets" do

    expect(find(:id,'user_followers_count').text.to_i).to eq(@user.followers.count)
    expect(find(:id,'user_following_count').text.to_i).to eq(@user.following.count)
    expect(find(:id,'user_tweets_count').text.to_i).to eq(@user.tweets.count)
    
  end

  it "shows user credentials correctly" do

      expect(page).to have_content(@user.user_name)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.bio)
      
  end

end