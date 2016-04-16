Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt/ do
    resources :rooms
    resources :users
  end

  get '/:locale' => 'home#index', locale: /en|pt/
  resource :confirmation, only: [:show]
  resource :user_sessions, only: [:create, :new, :destroy]
  root 'home#index'


end
