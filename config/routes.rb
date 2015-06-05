Rails.application.routes.draw do

  get 'static/home'

  get 'static/about'

  get 'static/contact'

  root 'users#index'
  get '/tests' => 'tests#index'
  get '/search' => 'tests#search', as: :search_items


  get "users/" => "users#index"
  get "items/" => "items#index"
  get "posts/" => "posts#index"

  get "users/new" => "users#new"
  get "items/new" => "items#new", as: :new_item
  get "posts/new" => "posts#new", as: :new_post
  get "votes/" => "votes#create"
  get "login" => "sessions#new"

  get "users/:id" => "users#show", as: :user
  get "items/:id" => "items#show", as: :item
  get "posts/:id" => "posts#show", as: :post
  

  post "users/" => "users#create"
  post "items/" => "items#create"
  post "posts/" => "posts#create"
  post "votes/" => "votes#create"
  post "login" => "sessions#create"

  get "users/:id/edit" => "users#edit", as: :edit_user
  get "items/:id/edit" => "items#edit", as: :edit_item
  get "posts/:id/edit" => "posts#edit", as: :edit_post

  patch "users/:id" => "users#update"
  patch "items/:id" => "items#update"
  patch "posts/:id" => "posts#update"
  patch "votes/:id" => "votes#update"

  delete "logout" => "sessions#destroy"
  delete "posts/:id" => "posts#destroy", as: :delete_post
  delete "users/:id" => "users#destroy", as: :delete_user
  delete "votes/:id" => "votes#destroy", as: :delete_vote

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
end
