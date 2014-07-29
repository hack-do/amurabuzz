TwitterApp::Application.routes.draw do
  #get "user/profile"
  get "user/friends"
  get "user/friend_profile"
  get "user/all_users"
  get "user/follow"
  get "user/unfollow"
  get "user/create"
  

  get "main/home"
  get "main/xtra"

   match ':id/all_users' => 'user#all_users', :via => :get, :as => 'all_users'    
   match ':uid/tweet/:id' => 'tweets#show#:id', :via => :get,:constraints => { :uid => 'me' }, :as => 'my_tweet' 
   match ':uid/tweet_edit/:id' => 'tweets#edit#:id', :via => :get,:constraints => { :uid => 'me' }, :as => 'edit_my_tweet' 
   match ':uid/tweet_update/:id' => 'tweets#update#:id', :via => :patch,:constraints => { :uid => 'me' }, :as => 'update_my_tweet' 

  match ':id/home' => 'user#home', :via => :get,
                                     :constraints => { :id => 'me' }, :as => 'my_home'    
  match ':id/tweets' => 'tweets#index', :via => :get,
                                     :constraints => { :id => 'me' }, :as => 'my_tweets'    
  match ':id/profile' => 'user#profile', :via => :get,
                                     :constraints => { :id => 'me' }, :as => 'my_profile' 
  match ':id/friends' => 'user#friends', :via => :get,
                                     :constraints => { :id => 'me' }, :as => 'my_friends'      

  match ':id/tweets' => 'tweets#index', :via => :get
  #match ':id/profile' => 'user#friend_profile', :via => :get

 
  
  devise_for :users,:controllers => {registrations: 'registrations',sessions: 'sessions'}

  resources :users do
     resources :tweets
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
