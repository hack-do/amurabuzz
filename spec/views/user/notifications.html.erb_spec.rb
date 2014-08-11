require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do
  
  before :each do
    @user = FactoryGirl.build(:user)
    @user1 = FactoryGirl.build(:user1)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    @user.confirmed_at = Time.now
    @user.save
    @user1.confirmed_at = Time.now
    @user1.save
    login_as @user,:scope => :user
     #puts "#{@user.inspect}"

     @user1.follow!(@user.id)
     @activity = Activity.first#find(:key "follow",)

     @user1.follow!(@user.id)
     @activity = Activity.first
     @user.follow!(@user1.id)
   	 @activity1 = Activity.last
     visit my_notifications_path
     puts "Current Path : #{current_path}"
  end

  it "displays friends notifications correctly" do
  	
  	within '#f_act' do
   		expect(find("#activity#{@activity.id}"))
   	end

  end

   it "displays its own notifications correctly" do
   	
   	click_on 'My Activities'

   	within '#my_act' do
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