Rails.application.routes.draw do
  devise_for :users

  resources :conversations do
    post :private
  end

  get 'logs', to: 'home#logs'
  root 'home#index'
end
