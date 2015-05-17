require 'rails_helper'

RSpec.describe TweetsController do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:tweet) {FactoryGirl.create :tweet, user_id: user.id}

  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["HTTP_REFERER"] = '/'
      user.confirm!
      sign_in user
  end

      describe "GET show " do
          # it "should route to show tweet" do
          #   expect(:get => my_tweet_path('me',tweet.id)).
          #   to route_to(:controller => "tweets", :action => "show",user_id: 'me',id: tweet.id.to_s)
          #   expect(response.status).to eq(200)
          # end
          it "should render show template" do
            get "show",:user_id => 'me', controller: 'tweets',id: tweet.id
            expect(response).to render_template("show")
          end

        it "assigns @tweet" do
             get "show",:user_id => 'me', controller: 'tweets',id: tweet.id
            expect(assigns(:tweet)).to eq(tweet)
        end
      end

      describe "PATCH update" do
        # it "should route to update my tweet" do
        #    expect(:patch => update_my_tweet_path('me',tweet.id)).to route_to(:controller => "tweets", :action => "update",user_id: 'me',id: tweet.id.to_s)
        #    expect(response.status).to eq(200)
        # end
      end

      describe "POST tweet" do
          it "should create a new tweet" do
              tweet_params = FactoryGirl.attributes_for(:tweet)
             xhr :post,"create",controller: "tweets" ,user_id:user, id: tweet,action: "create",tweet: tweet_params
          end
       end



      # describe "GET likes" do
        # it "should route to likes path" do
        #   expect(:get => tweets_likes_path).
        #   to route_to(:controller => "tweets", :action => "likes")
        #   expect(response.status).to eq(200)
        # end
      #   it "should render likes template" do
      #     xhr :get, 'likes',controller: 'tweets',id: tweet.id,user_id: "me"
      #     expect(response).to render_template('likes')
      #   end
      # end



     # describe "POST like" do
     #  it "should like(vote) a tweet" do
     #      xhr :post,"vote",controller: "tweets",action: 'votes',id: tweet.id,user_id: "me",type: "Like"
     #      expect(assigns(:value)).to be(1)
     #  end

     #   it "should unlike(vote) a tweet" do
     #      xhr :post,"vote",controller: "tweets",action: 'votes',id: tweet.id,user_id: "me",type: "Unlike"
     #      expect(assigns(:value)).to be(0)
     #  end
     # end


end
