Rails.application.routes.draw do
  devise_for :users

  # resources :conversations, only: [:create] do
  #   member do
  #     post :close
  #   end

  #   resources :messages, only: [:create]
  # end

  resources :conversations do
    post :private
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  root 'home#index'
end
