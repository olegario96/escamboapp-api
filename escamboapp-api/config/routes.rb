Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :user

  resources :user do
    resources :post , only: [:index, :show, :destroy], module: 'user'
  end

  resources :category, only: [:index, :show]

  resources :category do
    resources :post, only: [:index, :show], module: 'category'
  end

  resources :post, only: [:create, :update, :destroy]
end
