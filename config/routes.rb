AmuraBuzz::Application.routes.draw do

  devise_for :users,:controllers => {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }
  # match 'users/auth/:provider/callback' => 'omniauthcallbacks#facebook' ,via: :get  devise_for :users,:controllers => {registrations: 'registrations',:omniauth_callbacks => "users/omniauth_callbacks",:sessions => "sessions"}


  resources :users, :defaults => { :id => 'me',:user_id => 'me' } do
    resources :chats,only:[:create] do
      get :init,on: :collection
    end
    resources :activities,:only => [:index]
    resources :tweets do
      resources :rs_evaluations,:only => [:index,:create]
      get :stream
    end
    member do 
      get 'relate/:followed_id' => "users#relate", :as => 'relate'
      get :profile
      get :followers
      get :following
    end
  end
  
  root 'users#show'
end
