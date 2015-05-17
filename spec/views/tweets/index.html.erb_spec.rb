require 'rails_helper'
describe 'tweets/_index.html.erb', :js => true do

	before :each do
	   # Warden.test_mode!
  	 @tweet = FactoryGirl.create(:tweet)
  	 @user = @tweet.user
	   @request.env["devise.mapping"] = Devise.mappings[@user]
     @urls = Rails.application.routes.url_helpers
	   login_as(@user, :scope => :user)

	   visit @urls.user_path('me')
	end

  it "goes to timeline page" do
    within ("#tweet#{@tweet.id}") do
    	expect(page).to have_content(@tweet.content)
    end
  end

  it "shows tweet" do
    within ("#tweet#{@tweet.id}") do
      find(".tweet-options").click
      find(".show-tweet").click
    end  	
    expect(page).to have_content(@tweet.content)
  end

  it "edit tweet" do
    within ("#tweet#{@tweet.id}") do
      find(".tweet-options").click
      find(".edit-tweet").click
    end
  	new_content = Faker::Lorem.characters(160)
    find("#tweet-input").set(new_content)
	  click_on "Post"

    expect(page).to have_content(new_content)
 end

  # it " does not delete tweet" do
  # 	find(:id,"tweet#{@tweet.id}").find(".sr-only").click
  #   dialog = page.driver.browser.switch_to.alert
  #   expect(dialog.text).to eq("Are you sure?")
  #   dialog.dismiss
  #  	expect(page).to have_content(@tweet.content)
  # end

   it "toggles from like to unlike" do
    within ("#tweet#{@tweet.id}") do
      click_on "Like"	
    end
    expect(page).to have_content("Unlike")
		expect(page).to have_content("1 Like")

    within ("#tweet#{@tweet.id}") do
    	click_on "Unlike"
    end
		expect(page).to have_content("Like")
		expect(page).to have_content("0 Likes")
	end

	it "displays email and goes to profile" do
    within ("#tweet#{@tweet.id}") do
  		click_link("#{@user.email}")
    end
		expect(page).to have_content("#{@user.email}")
		expect(page).to have_content("#{@user.name}")
	end

  it "display likers" do
    within ("#tweet#{@tweet.id}") do
     	click_on "Like"
    end
		expect(page).to have_content("1 Like")

    within ("#tweet#{@tweet.id}") do
  		click_on ("1 Like")
    end
    expect(page).to have_content("#{@user.user_name}")
	end

  it "creates new tweet" do
    find(".new-tweet-link").click
    expect(page).to have_content("Post a Tweet")
    expect(page).to have_content("160")
    find("#tweet-input").set("test tweet 2")
    find(:id,"post_tweet").click
    expect(page).to have_content(@tweet.content)
   end

  it "does not create new tweet" do
    find(".new-tweet-link").click
    find("textarea[placeholder='Tweet message ...']").set "test tweet 2"
    find("#tweet-input").set("test tweet 2")
    click_on("Close")
    expect(page).to_not have_content("test tweet 2")
  end

  it "deletes tweet" do
    Capybara.current_driver = :selenium

    within ("#tweet#{@tweet.id}") do
      find(".tweet-options").click
      find(".delete-tweet").click
    end

    dialog = page.driver.browser.switch_to.alert
    expect(dialog.text).to eq("Are you sure?")
    # dialog.accept
    # execute_script("window.confirm = function(){return true;}")
    expect(page).to_not have_content(@tweet.content)
    expect(Tweet.count).to eq(0)
  end
end