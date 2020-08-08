Rails.application.routes.draw do
  root 'home#index'
  resources :docs

  resources :contact

  resources :pages do
    collection do
      get :download
      get :about
    end
  end

  resources :pay, only: [:index] do
    collection do
      post :alipay_app_notify
      post :alipay_wap_notify
      post :alipay_refund_notify
    end
  end

  resources :areas do
    member do
      get :options
    end
  end

  resources :download do
    collection do
      get :android
    end
  end

  resources :test

  get 'weixin/auth'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  # api
  mount API => '/api'

  mount StoreAPI => '/store_api'

  mount GrapeSwaggerRails::Engine => '/swagger'

  require 'sidekiq/web'
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
