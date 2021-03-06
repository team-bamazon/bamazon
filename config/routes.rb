Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root "products#index"
  # resources :products, [:index]
  resources :carts, only: [:new, :show, :edit, :create, :destoy]
  resources :orders, only: [:index, :edit, :update] do
    member do
      get 'new_select_address'
      post 'order_new_address_create'
    end
  end
  resources :order_products, only: [:create, :edit]
  resources :users, only: [:index, :edit, :update] do
    member do
      get   'user_info'
      get   'edit_name'
      get   'edit_email'
      get   'new_phone_number'
      get   'edit_password'
      patch 'update_email'
      patch 'update_name'
      patch 'update_phone_number'
      patch 'update_password'
    end
    get 'edit_address'
    resources :addresses, only: [:new, :create, :destroy, :edit, :update] do
      member do
        patch 'update_status'
      end
    end
    resources :payment_informations, only: [:index, :create, :destroy, :edit, :update]
    resources :wanteds, only: [:show, :create, :destroy, :update]
    resources :wanted_products, only: [:create, :update, :destroy]
  end

  resources :products, only: [:show] do
    resources :cart_products, only: [:create, :destroy, :edit, :update]
    collection do
      get   'search'
      get   'suggest'
    end
    resources :reviews, only: [:new, :create]
  end
  resources :product_categories, only: [:index]
end
