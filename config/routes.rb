Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :items, except: [:update, :destroy]
    resources :bulk_discounts, except: [:update]
  end

  patch '/merchants/:merchant_id/invoices/:id', to: 'invoice_items#update'

  patch '/merchants/:merchant_id/items', to: 'items#update'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  patch '/merchants/:merchant_id/bulk_discounts/:id', to: 'bulk_discounts#update'

  resources :admin, only: [:index]

  namespace :admin, except: [:destroy, :update] do
    resources :merchants, :invoices, except: [:destroy, :update]
  end

  patch '/admin/invoices/:id', to: 'admin/invoices#update'
  patch '/admin/merchants/:id', to: 'admin/merchants#update'
end
