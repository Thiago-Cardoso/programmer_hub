Rails.application.routes.draw do

  root 'pages#home'

  resources :comments, only: [:create, :destroy, :edit, :update]
  resources :posts, only: [:index, :show, :create, :destroy, :edit, :update] do
    member do
      post '/like', to: "likes#create", as: "like"
      delete '/like', to: "likes#destroy", as: "unlike"
    end
  end

  post '/follows', to: "follows#create", as: "follow"
  delete '/follows', to: "follows#destroy", as: "unfollow"

  get '/profile/:id', to: "users#show", as: "user"
  get '/profile/:id/followings', to: "users#followings", as: "following"
  get '/profile/:id/followers', to: "users#followers", as: "followers"
  post '/users/search', to: "users#search", as: :search
  get '/users/search', to: "users#search"

  #devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  devise_for :users, :controllers => { registrations: 'registrations' }
end
