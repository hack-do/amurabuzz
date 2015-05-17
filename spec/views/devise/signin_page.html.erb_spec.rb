require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do

  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    visit new_user_session_path
  end

  it "signs me in" do
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_on 'Sign in'

    expect(page).to have_content "#{truncate(@user.user_name,length: 20)}"
  end

  it "doesnt signin invalid user" do
    fill_in 'Email', :with => Faker::Internet.safe_email
    fill_in 'Password', :with => Faker::Internet.password(8, 128)
    click_on 'Sign in'

    expect(page).to have_content 'Sign in'
  end
end