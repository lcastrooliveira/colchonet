Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt/ do
    resources :rooms
    resources :users
  end

  get '/:locale' => 'home#index', locale: /en|pt/
  resource :confirmation, only: [:show]
  root 'home#index'


end
