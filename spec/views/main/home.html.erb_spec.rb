require 'rails_helper'

describe "main/home.html.erb", :type => :view,js: true do
  
  before :each do
    Capybara.current_driver = :poltergeist
    visit root_path
  end

  it "loads successfully" do
        expect(render).to have_content('Amura Buzz')
        expect(page).not_to have_content('Home')
  end

  it "goes to signin link" do
      click_on 'Sign In'
      expect(page).to have_content 'Sign in'
      expect(current_path).to eq(new_user_session_path)
  end

  it "doesnt let guest to browze pages" do
      visit my_profile_path('me')
      expect(current_path).to eq(new_user_session_path)
  end

end