require 'rails_helper'
describe 'tweets/index.html.erb', :js => true do

	before :each do
    Capybara.current_driver = :selenium
	   Warden.test_mode!
  	 @tweet = FactoryGirl.create(:tweet)
  	 @user= @tweet.user
	   @request.env["devise.mapping"] = Devise.mappings[@user]
     @urls = Rails.application.routes.url_helpers
	   login_as(@user, :scope => :user)

	 visit @urls.user_path('me')
	end

  it "goes to timeline page" do
  	expect(page).to have_content(@tweet.content)
  end

  it "shows tweet" do
  	find(:id,"tweet#{@tweet.id}").find(".fa-ellipsis-h").click
    find(:id,"tweet#{@tweet.id}").find(".fa-info").click
  	expect(page).to have_content("Edit")
  end

  it "edit tweet" do
    find(:id,"tweet#{@tweet.id}").find(".fa-ellipsis-h").click
  	find(:id,"tweet#{@tweet.id}").find(".fa-pencil").click
  	expect(page).to have_content("max 160 characters")
  	find(:id,"tweet_content").set("updated test tweet")
	  click_on "Update Tweet"
	  expect(page).to have_content("updated test tweet")
 end

  # it " does not delete tweet" do
  # 	find(:id,"tweet#{@tweet.id}").find(".sr-only").click
  #   dialog = page.driver.browser.switch_to.alert
  #   expect(dialog.text).to eq("Are you sure?")
  #   dialog.dismiss
  #  	expect(page).to have_content(@tweet.content)
  # end

   it "toggles from like to unlike" do
  	click_on "Like"
		expect(page).to have_content("Unlike")
		expect(page).to have_content("1 Like")
		click_on "Unlike"
		expect(page).to have_content("Like")
		expect(page).to have_content("0 Likes")
	end

	it "displays email and goes to profile" do
		click_link("#{@user.email}")
		expect(page).to have_content("#{@user.email}")
		expect(page).to have_content("#{@user.name}")
	end

  it "display likers" do
   	click_on "Like"
		expect(page).to have_content("1 Like")
		click_on ("1 Like")
  	expect(page).to have_content("#{@user.user_name}")
	end

  it "creates new tweet" do
    find(:id,"tweet_modal_link").click
    expect(page).to have_content("Post a Tweet")
    expect(page).to have_content("160")
    find("textarea[placeholder='Tweet message ...']").set "test tweet 2"
    find(:id,"tweet_msg").set("test tweet 2")
    find(:id,"post_tweet").click
    expect(page).to have_content(@tweet.content)
   end

  it "does not create new tweet" do
    find(:id,"create_tweet_link").click
    find("textarea[placeholder='Tweet message ...']").set "test tweet 2"
    find(:id,"tweet_msg").set("test tweet 2")
    click_on("Close")
    expect(page).to_not have_content("test tweet 2")
  end

  it "deletes tweet" do
    find(:id,"tweet#{@tweet.id}").find(".fa-ellipsis-h").click
    # within (".panel") do
      find(".fa-times").click
    # end
    dialog = page.driver.browser.switch_to.alert
    expect(dialog.text).to eq("Are you sure?")
    dialog.accept
    expect(page).to_not have_content(@tweet.content)
  end

end