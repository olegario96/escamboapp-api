Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'

  post 'signup', to: 'user#create'

  post 'search', to: 'search#search'

  resources :user

  # /user/:id/post
  resources :user do
    resources :post, only: [:index, :show, :destroy], module: 'user'
  end

  resources :category, only: [:index, :show]

  resources :permission, only: [:index, :show]

  # /category/:id/post
  resources :category do
    resources :post, only: [:index, :show], module: 'category'
  end

  resources :post

  # /post/:id/comment
  resources :post do
    resources :comment, only: [:index, :show], module: 'post'
  end

  resources :comment

end
