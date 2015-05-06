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
          xhr :get, 'new', user_id: tweet.user_id, id: tweet
          expect(response).to render_template('new')
        end
      end

      describe "POST tweet" do

          it "should create a new tweet" do
              tweet_params = FactoryGirl.attributes_for(:tweet)
             xhr :post,"create",controller: "tweets" ,user_id:user, id: tweet,action: "create",tweet: tweet_params
          end
       end 

    	

      describe "GET likes" do
        
        it "should route to likes path" do
          expect(:get => tweets_likes_path).
          to route_to(:controller => "tweets", :action => "likes")
          expect(response.status).to eq(200)
        end

        it "should render likes template" do 
          xhr :get, 'likes',controller: 'tweets',tweet_id: tweet
          expect(response).to render_template('likes')
        end
      end     

   

     describe "POST like" do
      it "should like(vote) a tweet" do
          xhr :post,"vote",user_id:tweet.user_id,controller: "tweets",action: 'votes',id:tweet.id,type: "Like"
          expect(assigns(:value)).to be(1)
      end

       it "should unlike(vote) a tweet" do
          xhr :post,"vote",user_id:tweet.user_id,controller: "tweets",action: 'votes',id:tweet.id,type: "Unlike"
          expect(assigns(:value)).to be(0)
      end
     end    


end
