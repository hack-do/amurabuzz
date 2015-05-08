require "rails_helper"

describe "sign_up process",js: true  do
  before :each do
  	 @user = FactoryGirl.create(:user)
	   @request.env["devise.mapping"] = Devise.mappings[@user]
		#Capybara.current_driver = :poltergeist
    visit new_user_registration_path
  end

  it "sign_up user successfully" do
  	    expect(page).to have_content("Sign up")
  	   	fill_in "Email",        with: "abc@xyz.com"
        fill_in "Password",     with: @user.password
        fill_in "Password confirmation",     with: @user.password
        fill_in "User name",    with: "exampleguy"
        click_on 'Sign up'

        expect(page).to have_content("exampleguy")
  end

  it "error for no email" do
        fill_in "Password",     with: @user.password
        fill_in "Password confirmation",     with: @user.password
        fill_in "User name",    with: "exampleguy"
        click_on 'Sign up'

        expect(page).to have_content("Email can't be blank")
  end

  it "error for no password" do
          fill_in "Email",        with: "aaaaaaa"
          fill_in "User name",    with: "exampleguy"
          click_on 'Sign up'

          expect(page).to have_content("Password can't be blank")
  end

  it "error for no username" do
        fill_in "Email",        with: "abc@xyz.com"
        fill_in "Password",     with: @user.password
        fill_in "Password confirmation",     with: @user.password
        click_on 'Sign up'

        expect(page).to have_content("User name can't be blank")
  end

it "submit blank form" do
  click_on 'Sign up'
  expect(page).to have_content("Email can't be blank")
  expect(page).to have_content("Password can't be blank")
  expect(page).to have_content("User name can't be blank")
end


end