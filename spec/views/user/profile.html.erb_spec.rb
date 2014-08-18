require 'rails_helper'

describe "devise/session/new.html.erb", :type => :view,js: true do
  
  before :each do
    @user = FactoryGirl.build(:user)
    @request.env["devise.mapping"] = Devise.mappings[@user]
    @user.confirmed_at = Time.now
    @user.save
    login_as @user,:scope => :user
     visit my_profile_path('me')
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