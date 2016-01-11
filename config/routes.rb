  Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }


  devise_scope :user do
   get "/partner/sign_up" => "registrations#new_partner"
  end


  root to: 'pages#home'
  get "/fonctionnement"   => "pages#fonctionnement"
  get "/espacerestaurants" => "pages#espace_restaurants"
  get "/espacerestaurants" => "pages#espace_restaurants"
  get "/conditionsgenerales" => "pages#conditionsgenerales"
  get "/chartepartenaire" => "pages#chartepartenaire"
  get "/charteutilisateur" => "pages#charteutilisateur"



  resources :contacts, only: [:new, :create]
  resources :newsletters, only: [:new, :create]


  resources :meals, only: [ :index, :show]


  resources :restaurants do
    resources :meals, only: [:new, :create, :edit, :update, :destroy]
  end

  resource :cart, only: [:show, :destroy], controller: 'cart' do
    resources :order_meals, only: [:create]
    resources :payments,    only: [:new, :create, :show]
  end

  resources :orders,  only: [:index, :show, :create]
  resources :users,   only: [:show]





  # rot 'welcome#index'

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
