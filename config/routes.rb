Rails.application.routes.draw do
  namespace :staff do
    get 'login' => 'sessions#new', as: :login
    get 'session' => 'sessions#index', as: :session_failed
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    root 'top#index'
  end

  namespace :admin do
    get 'login' => 'sessions#new', as: :login
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
  end

  get '*anything' => 'errors#routing_error'
end
