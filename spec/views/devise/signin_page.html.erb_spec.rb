require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do

  before :each do
    @user = FactoryGirl.build(:user)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    @user.confirm!
     visit new_user_session_path
  end

  it "signs me in" do
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password

    click_on 'Sign in'



    expect(page).to have_content "#{@user.name}"
  end

  it "doesnt signin invalid user" do
     fill_in 'Email', :with => "random"
     fill_in 'Password', :with => "bs1234567"

     click_on 'Sign in'

    expect(page).to have_content 'Sign in'
  end


end