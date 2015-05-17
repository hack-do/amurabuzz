require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do

  before :each do
    @user = FactoryGirl.create(:user)
    @user1 = FactoryGirl.create(:user)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    @user1.follow(@user.id)
    @activity = Activity.first
    @user.follow(@user1.id)
 	  @activity1 = Activity.last
    @urls = Rails.application.routes.url_helpers

    login_as @user,:scope => :user
    visit @urls.user_activities_path
  end

  it "displays friends notifications correctly" do
  	within '#friends_activities' do
   		expect(find("#activity#{@activity.id}"))
   	end

  end

   it "displays its own notifications correctly" do
   	click_on 'My Activities'

   	within '#my_activities' do
   		expect(find("#activity#{@activity1.id}"))
   	end
   end

 	it "displays its own notifications in Notifications drawer correctly" do
   	find('#notification_globe').click
    sleep(2.seconds)
   	within '#user_notifications' do
      expect(find("#activity#{@activity.id}"))
   	end
 end

end