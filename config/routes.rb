Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :items, only: [:index, :show]
    resources :dashboard, only: [:index]
  end

  resources :admin, only: [:index]
end
