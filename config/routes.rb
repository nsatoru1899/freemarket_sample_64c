Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'tests#index'
  resources :tests
  # 購入ページでのカード登録のためのURLを設定
  get 'buy/cards/new' => 'cards#new'
  resources :cards, only: %i[create show destroy]

  resources :items, only: %i[new create show edit update destroy] do
    member do
      get 'buy', to: 'items#buy'
      post 'pay', to: 'items#pay'
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
    collection do
      get 'complete', to: 'items#complete'
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :categories, only: %i[index]
  # ユーザーマイページでのカード登録のためのURLを設定
  namespace :users do
    resources :cards, only: :new
  end

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
