Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'tests#index'
  resources :tests
  resources :cards, only: %i[new create show destroy]
  resources :items, only: %i[new create show edit update destroy] do
    member do
      get 'buy', to: 'items#buy'
      post 'pay', to: 'items#pay'
    end
    collection do
      get 'complete', to: 'items#complete'
    end
  end

  resources :categories, only: %i[index]

  resources :users do
    collection do
      get 'user_my_page'
      get 'sign_out'
    end
  end

  devise_scope :user do
    post 'users/sign_up/complete' => 'users/registrations#complete'
  end
end
