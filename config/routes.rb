Rails.application.routes.draw do
  config = Rails.application.config.baukis

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      get 'login' => 'sessions#new', as: :login
      get 'session', to: redirect('/login')
      resource :session, only: %i[create destroy]
      resource :account, only: %i[show edit update]
      root 'top#index'
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      get 'login' => 'sessions#new', as: :login
      get 'session', to: redirect('/admin/login')
      resource :session, only: %i[create destroy]
      resources :staff_members
      root 'top#index'
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  get '*anything' => 'errors#routing_error'
end
