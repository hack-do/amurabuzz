AmuraBuzz::Application.routes.draw do

  devise_for :users,:controllers => {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }
  # match 'users/auth/:provider/callback' => 'omniauthcallbacks#facebook' ,via: :get  devise_for :users,:controllers => {registrations: 'registrations',:omniauth_callbacks => "users/omniauth_callbacks",:sessions => "sessions"}

  get 'stream' => 'tweets#stream', :as => 'my_stream'
  get 'sse' => 'tweets#sse', :as => 'my_sse'

  resources :users, :defaults => { :id => 'me' } do
     resources :tweets, :defaults => { :user_id => 'me' } do
        member do 
          get :likes
          post :vote
        end
     end
    member do 
      get 'follow/:followed_id' => "user#follow", :as => 'follow'
      get 'unfollow/:unfollowed_id' => "user#unfollow", :as => 'unfollow'
      get :profile
      get :notifications
      get :followers
      get :following
    end
  end

  root 'main#home'

end