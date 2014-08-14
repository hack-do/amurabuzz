TwitterApp::Application.routes.draw do
  

  #get "user/profile"
  get "user/friends"
  get "user/friend_profile"
  get "user/all_users"
  get "user/follow"
  get "user/unfollow"
  get "me/notifications" => "user#notifications",as: "my_notifications"


  get "backbone/bb_index" => "user#bb_index"
  get "backbone/bb_show" => "user#bb_show"
  get "backbone/" => "main#my_backbone"
  get "backbone/*ng" => "main#my_backbone"
  get "backbone/things/show/things/:id" => "thing#show"

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

 
  #match 'users/auth/:provider/callback' => 'omniauthcallbacks#facebook' ,via: :get
  resources :things
  devise_for :users,:controllers => {registrations: 'registrations',:omniauth_callbacks => "users/omniauth_callbacks",:sessions => "sessions"}

  resources :users do
     resources :tweets do
        member { post :vote }
     end
  end
  #  resources :users do
  #   resources :tweets
  # end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
