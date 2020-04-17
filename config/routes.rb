Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'tests#index'
  resources :tests
  resources :items, only: [:new, :create, :show, :edit]

  devise_scope :user do
    post 'users/sign_up/complete' => 'users/registrations#complete'
  end
end
