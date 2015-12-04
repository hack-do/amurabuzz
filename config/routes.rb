AmuraBuzz::Application.routes.draw do

  get '/stream' => 'stream#index'

  get '/chat' => 'chat/private_chats#chat'
  get '/chats' => 'chat/private_chats#index'

  get '/public_chat' => 'chat/public_chats#chat'
  get '/public_chats' => 'chat/public_chats#index'

  devise_for :users,:controllers => {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }
  # match 'users/auth/:provider/callback' => 'omniauthcallbacks#facebook' ,via: :get  devise_for :users,:controllers => {registrations: 'registrations',:omniauth_callbacks => "users/omniauth_callbacks",:sessions => "sessions"}

  resources :users, :defaults => { :id => 'me',:user_id => 'me' } do
    member do
      get :profile
      get 'follow/:followed_id' => "relationships#follow", :as => 'follow'
      get 'unfollow/:followed_id' => "relationships#unfollow", :as => 'unfollow'
      get "friends" => "relationships#friends", :as => 'friends'
      get "followers" => "relationships#followers", :as => 'followers'
      get "following" => "relationships#following", :as => 'following'
    end

    resources :images
    resources :chats, only: [] do
      post :send_message, on: :collection
    end
    resources :activities,:only => [:index]
    resources :tweets do
      post :add_picture, on: :member
      resources :votes, only: [:index,:create]
      resources :comments, only: [:index,:create]
      resources :shares, only: [:index,:create]
    end
  end

  root 'users#show'
end
