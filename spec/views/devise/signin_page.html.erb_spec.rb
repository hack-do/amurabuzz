require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do
  
  before :each do
    @user = FactoryGirl.build(:user)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    @user.confirm!
     #puts "#{@user.inspect}"

     visit new_user_session_path
  end

  it "signs me in" do
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password

    click_on 'Sign in'

    # Capybara.default_selector = :xpath
    # email = find(:id,'user_email')
    # password = find(:id,'user_password')
    #email.set(@user.email)
    #password.set(@user.email)
    # puts "------Email : #{email.value}------"
    # puts "------Password : #{password.value}------"
    
    expect(page).to have_content 'Signed in successfully'
  end

  it "doesnt signin invalid user" do
     fill_in 'Email', :with => "random"
     fill_in 'Password', :with => "bull-shit"

     click_on 'Sign in'
      
    expect(page).to have_content 'Invalid'
  end


end