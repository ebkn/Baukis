Rails.application.routes.draw do
  namespace :staff, path: '/' do
    get 'login' => 'sessions#new', as: :login
    get 'session', to: redirect('/login')
    resource :session, only: %i[create destroy]
    resource :account, only: %i[index edit update]
    root 'top#index'
  end

  namespace :admin do
    get 'login' => 'sessions#new', as: :login
    get 'session', to: redirect('/admin/login')
    resource :session, only: %i[create destroy]
    resources :staff_members
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
  end

  get '*anything' => 'errors#routing_error'
end
