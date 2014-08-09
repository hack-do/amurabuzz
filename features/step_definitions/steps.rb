Given(/^i am a valid user with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  @user = FactoryGirl.create(:user,email: arg1,password: arg2)
  @user.confirm!
end

Given(/^i visit Sign in page$/) do
  visit new_user_session_path
end

Given(/^i fill in email with "(.*?)"$/) do |email|
  fill_in "Email", with: email
end

Given(/^i fill in password with "(.*?)"$/) do |secret|
  fill_in "Password", with: secret
end

When(/^i click on Sign in$/) do
  click_on "Sign in"
end

Then(/^page should show message "(successfully)"$/) do |success|
  #puts "after sign in"
  expect(page).to have_content(success)
end



Given(/^i Sign In as "(.*?)"$/) do |email|
  password = 'secretpassword'
  @user1 = FactoryGirl.create(:user,:email => email, :password => password, :password_confirmation => password)
  visit new_user_session_path
  fill_in "Email", :with => @user1.email
  fill_in "Password", :with => @user1.password
  click_button "Sign in"
end

Given(/^i create a tweet "(.*?)"$/) do |arg1|
  find(".tweet_modal").click
  find("#tweet_msg").set arg1
  click_on "Post"
  #puts "created tweet"
end



When(/^i am on index page$/) do
	visit my_tweets_path('me')	
end

Then(/^page should show tweet "(.*?)"$/) do |arg1|
  #puts page.inspect
	expect(page).to have_content(arg1)
end

When(/^i click on timeline$/) do
 click_on "Timeline"
end

Then(/^page should show content "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end


When(/^i click on eyefavicon$/) do
  find("#show").click
end

Then(/^page should go to show page$/) do
  #sleep(2)
  expect(page).to have_content("Edit | Back")
end


When(/^i click on pencilfavicon$/) do
 find("#edit").click
end

Then(/^page should go to edit page$/) do
  expect(page).to have_content("max 160 characters")
end


When(/^i click on Like$/) do
  click_on "Like"
end

Then(/^likes should increase by (\d+)$/) do |arg1|
   expect(page).to have_content("1 Like")
end


Given(/^i liked a tweet "(.*?)"$/) do |arg1|
    find(".tweet_modal").click
    find("#tweet_msg").set arg1
    click_on "Post"
   # puts "created tweet"
    click_on "Like"
end

When(/^i click on Unlike$/) do
  click_on "Unlike"
end

Then(/^likes should decrease by (\d+)$/) do |arg1|
  expect(page).to have_content("0 Likes")
end

When(/^i click on close$/) do
  within(".panel-heading") do
    click_on("Close")
  end
end

Then(/^page should not have "(.*?)"$/) do |arg1|
  expect(page).not_to have_content(arg1)
end



Given(/^another valid user exists$/) do
  @user2 = FactoryGirl.build(:user)
  @user2.confirm!
end

Given(/^i am on friends page$/) do
  visit my_friends_path('me')
end

When(/^i click on Make friends$/) do
 click_on("Make friends")
end

Then(/^page should display another users email$/) do
  expect(page).to have_content(@user2.email)
end



Given(/^i am on all users page$/) do
  visit all_users_path('me')
end

When(/^i click on Follow of another user$/) do
  find("\##{@user2.id}f").click
end

When(/^i visit friends page$/) do
  visit my_friends_path('me')
end

Then(/^that user should be in my following table$/) do
 expect(page).to have_content(@user2.email)
end


Given(/^i am following a user$/) do
  visit all_users_path('me')
  find("\##{@user2.id}f").click
  visit my_friends_path('me')
end

When(/^i click on Unfollow$/) do
  click_on("Unfollow")
end

Then(/^that user must not be in my following table$/) do
  expect(page).not_to have_content(@user2.email)
end


When(/^i click on Me button$/) do
  click_on("Me")
end

Then(/^i should go to profile page$/) do
  expect(page).to have_content(@user1.user_name)
end

Given(/^i visit my profile$/) do
  visit my_profile_path('me')
end

When(/^i click on Edit$/) do
  click_on("Edit")
end

Then(/^i should go to Edit registration page$/) do
  expect(page).to have_content("Edit User")
end



When(/^i visit notifications page$/) do
  visit my_notifications_path('me')
end

When(/^i click on My Activities$/) do
  click_on("My Activities")
end

Then(/^page should show "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

When(/^i Click on "(.*?)"$/) do |arg1|
  click_on "#{arg1}"
end

When(/^i click on Logout$/) do
  click_on "Logout"
end

Then(/^page should show signed out message "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

