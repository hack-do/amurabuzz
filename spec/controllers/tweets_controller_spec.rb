require 'rails_helper'

RSpec.describe TweetsController do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:tweet) {FactoryGirl.create :tweet, user_id: user.id}
 
  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["HTTP_REFERER"] = '/'
      # or set a confirmed_at inside the factory. Only necessary if you
      # are using the confirmable module
      user.confirm!
      sign_in user
  end
      describe "GET show " do
          it "should route to show tweet" do
            expect(:get => my_tweet_path('me',tweet.id)).
            to route_to(:controller => "tweets", :action => "show",uid: 'me',id: tweet.id.to_s)
            expect(response.status).to eq(200)
          end
          it "should render show template" do
            get "show",:uid => 'me', controller: 'tweets',id: tweet.id
            expect(response).to render_template("show")
          end

        it "assigns @tweet" do 
             get "show",:uid => 'me', controller: 'tweets',id: tweet.id
            expect(assigns(:tweet)).to eq(tweet)
        end
      end    

      describe "GET edit" do
           it "should route to edit my tweet" do
            expect(:get => edit_my_tweet_path('me',tweet.id)).
            to route_to(:controller => "tweets", :action => "edit",uid: 'me',id: tweet.id.to_s)
            expect(response.status).to eq(200)
          end
          it "should render edit template" do
            get "edit",:uid => 'me', controller: 'tweets',id: tweet.id
            expect(response).to render_template("edit")
           end
         it "assigns @tweet" do 
             get "edit",:uid => 'me', controller: 'tweets',id: tweet.id
            expect(assigns(:tweet)).to eq(tweet)
        end
      end

      describe "PATCH update" do
         it "should route to update my tweet" do
          
          expect(:patch => update_my_tweet_path('me',tweet.id)).to route_to(:controller => "tweets", :action => "update",uid: 'me',id: tweet.id.to_s)
          expect(response.status).to eq(200)
        end
      end   

      describe "GET new" do
        
        it "should route to new tweets" do
          expect(:get => new_user_tweet_path(user.id,tweet)).
          to route_to(:controller => "tweets", :action => "new",user_id: user.id.to_s,format: tweet.id.to_s)
          expect(response.status).to eq(200)
        end


        it "should render new template" do 
          get 'new', user_id: tweet.user_id, id: tweet
          expect(response).to render_template('new')
        end
      end

    	describe "GET index" do 

        it "should route to my tweets" do
          expect(:get => my_tweets_path('me')).
          to route_to(:controller => "tweets", :action => "index",id: 'me')
          expect(response.status).to eq(200)
        end

        it "should render index template" do
          get "index", controller: 'tweets',:id => 'me'
          expect(response).to render_template("index")
        end

        it "assigns @tweets" do 
             get "index", controller: 'tweets',:id => 'me'
            expect(assigns(:tweets)).to include(tweet)
      	end
    end
end
