Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root "products#index"
  # resources :products, [:index]
  resources :carts, only: [:new, :show, :edit, :create, :destoy]
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
    resources :addresses, only: [:new, :create, :destroy, :edit, :update]
    resources :payment_informations, only: [:index, :create, :destroy, :edit, :update]
    resources :wanteds, only: [:index, :new, :show, :edit, :create, :destroy]
  end

  resources :products, only: [:show] do
    resources :wanted_products, only: [:create, :destroy, :edit, :update]
    resources :cart_products, only: [:create, :destroy, :edit, :update]
    collection do
      get   'search'
      get   'suggest'
    end
  end

end
