require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do

  before :each do
    @user = FactoryGirl.create(:user)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    @urls = Rails.application.routes.url_helpers

    login_as @user,:scope => :user
    visit @urls.profile_user_path
  end

  it "shows user credentials correctly" do
    within('.panel') do
        expect(page).to have_content(@user.user_name)
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.bio)
    end
  end

  it "routes to edit profile page on clicking Edit" do
    within('.panel') do
      click_on 'Edit'
    end
    expect(current_path).to eq(edit_user_registration_path)
  end
end