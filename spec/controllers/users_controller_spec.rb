require 'rails_helper'
include Devise::TestHelpers
  
RSpec.describe UserController, :type => :controller do
  	  let(:user) {FactoryGirl.create(:user)}
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
  
      # or set a confirmed_at inside the factory. Only necessary if you
      # are using the confirmable module
      user.confirm!
      sign_in user
  	end

   it "should have a current_user" do
       expect(subject.current_user).not_to be_nil
    end

  	describe "route tests" do
  	it "should route to home" do
       expect(:get => my_home_path('me')).
      to route_to(:controller => "user", :action => "home",id: 'me')
      expect(response.status).to eq(200)
    end
    it "should route to profile" do
      expect(:get => my_profile_path('me')).
      to route_to(:controller => "user", :action => "profile",id: 'me')
      expect(response.status).to eq(200)
    end

    it "should route to my friends" do
      expect(:get => my_friends_path('me')).
      to route_to(:controller => "user", :action => "friends",id: 'me')
      expect(response.status).to eq(200)
    end
    
    it "should route to my friends profile" do
      expect(:get => my_friend_path('me')).
      to route_to(:controller => "user", :action => "friend_profile",id: 'me')
      expect(response.status).to eq(200)
    end

    it "should route to my notifications" do
      expect(:get => my_notifications_path('me')).
      to route_to(:controller => "user", :action => "notifications",format: 'me')
      expect(response.status).to eq(200)
    end

    it "should route to all users" do
      expect(:get => all_users_path('me')).
      to route_to(:controller => "user", :action => "all_users",id: 'me')
      expect(response.status).to eq(200)
    end
  end

  describe "GET all_users" do 
    it "checks current_user is not in all_users" do
      get "all_users",controller: "user",id: 'me'
      expect(assigns(:users)).not_to include(user)
    end
  end

end

