TwitterApp::Application.routes.draw do


devise_for :users,:controllers => {registrations: 'registrations',:omniauth_callbacks => "users/omniauth_callbacks",:sessions => "sessions"}

  get "user/friends"
  get "user/friend_profile"
  get "user/all_users"
  get "user/follow"
  get "user/unfollow"
  get "me/notifications" => "user#notifications",as: "my_notifications"

  get "main/home"
  get "main/xtra"

  get "x" => "main#xtra"
  get "tweets/likes" => "tweets#likes"

  constraints :id => 'me' do
     get ':id/all_users' => 'user#all_users', :as => 'all_users'
     get ':id/home' => 'user#home', :as => 'my_home'
     get ':id/tweets' => 'tweets#index', :as => 'my_tweets'
     get ':id/profile' => 'user#profile', :as => 'my_profile'
     get ':id/friends' => 'user#friends', :as => 'my_friends'
     get ':id/tweets' => 'tweets#index'
  end

  constraints :uid => 'me' do
     get 'friend/:id' => 'user#friend_profile', :as => 'my_friend'
     get ':uid/tweet/:id' => 'tweets#show#:id', :as => 'my_tweet'
     get ':uid/tweet_edit/:id' => 'tweets#edit#:id', :as => 'edit_my_tweet'
     patch ':uid/tweet_update/:id' => 'tweets#update#:id', :via => :patch, :as => 'update_my_tweet'
  end


  #match ':id/profile' => 'user#friend_profile', :via => :get


  #match 'users/auth/:provider/callback' => 'omniauthcallbacks#facebook' ,via: :get  devise_for :users,:controllers => {registrations: 'registrations',:omniauth_callbacks => "users/omniauth_callbacks",:sessions => "sessions"}


  resources :users do
     resources :tweets do
        member { post :vote }
     end
  end

  root 'main#home'

end
