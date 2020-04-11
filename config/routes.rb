Rails.application.routes.draw do
  root :to => "web/board#show"

  scope module: :web do
    resource :board, only: :show
    resource :session, only: :new
  end

  resource :session, only: [:new, :create, :destroy]
  resources :developers, only: [:new, :create]
end