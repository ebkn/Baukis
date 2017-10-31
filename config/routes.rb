Rails.application.routes.draw do
  namespace :staff, path: '/' do
    get 'login' => 'sessions#new', as: :login
    get 'session' => 'sessions#index', as: :session_failed
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    root 'top#index'
  end

  namespace :admin do
    get 'login' => 'sessions#new', as: :login
    get 'session' => 'sessions#index', as: :session_failed
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    resources :staff_members
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
  end

  get '*anything' => 'errors#routing_error'
end
