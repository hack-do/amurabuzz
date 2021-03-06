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
    @urls = Rails.application.routes.url_helpers
    visit @urls.users_path('me')


  end

  # it "searches valid user correctly" do

  #   input = find('input[type=search]')
  #   input.set @user1.email
  #   expect(find('#all_users_datatable').text).to have_content @user1.user_name
  # end

  # it "search shows null result for invalid user" do
  #   input = find('input[type=search]')
  #   input.set "random"
  #   expect(find('#all_users_datatable').text).not_to have_content input.value
  # end

  it "goes to user profile" do
    click_on @user1.email
    expect(current_path).to eq(user_path(@user1.id))
  end

  # it "follows, unfollows user" do
  #   within('tr',text: @user1.email) do
  #     expect(page).to have_link("Follow")
  #     click_on 'Follow'
  #     expect(page).to have_link("Unfollow")
  #     click_on 'Unfollow'
  #     expect(page).to have_link("Follow")
  #   end
  # end

end