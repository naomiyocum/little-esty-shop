Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :bulk_discounts, only: [:index, :show, :new, :edit]
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :items, except: [:update, :destroy]
  end

  patch '/merchants/:merchant_id/invoices/:id', to: 'invoice_items#update'
  patch '/merchants/:merchant_id/items', to: 'items#update'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'
  post '/merchants/:merchant_id/bulk_discounts', to: 'bulk_discounts#create'
  delete '/merchants/:merchant_id/bulk_discounts/:id', to: 'bulk_discounts#destroy'
  patch '/merchants/:merchant_id/bulk_discounts/:id', to: 'bulk_discounts#update'
  
  resources :admin, only: [:index]
  namespace :admin, except: [:destroy, :update] do
    resources :merchants, :invoices, except: [:destroy, :update]
  end

  patch '/admin/invoices/:id', to: 'admin/invoices#update'
  patch '/admin/merchants/:id', to: 'admin/merchants#update'
end
