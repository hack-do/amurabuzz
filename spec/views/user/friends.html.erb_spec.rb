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
    puts "#{@user.inspect}"
    @user.follow!(@user1.id)
    @user1.follow!(@user.id)

    visit my_friends_path('me')
    puts "Current Path : #{current_path}"
  end

  it "goes to user profile (Followers)" do
    within(:id,'followers_table') do
      click_on @user1.email
      expect(current_path).to eq(my_friend_path(@user1.id))
    end
  end

  it "goes to user profile (Following)" do
    within('#following_table') do
      click_on @user1.email
      expect(current_path).to eq(my_friend_path(@user1.id))
    end
  end

  it "unfollows user and record is deleted from following table" do
    within('#following_table') do
      within('tr',text: @user1.email) do
        expect(page).to have_link("Unfollow")
        click_on 'Unfollow'
      end
      expect(page).not_to have_content(@user1.email)
    end
  end

end