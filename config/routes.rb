Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  get '/storage_units', to: 'storage_units#index'
  get '/storage_units/new', to: 'storage_units#new'
  post '/storage_units', to: 'storage_units#create'
  get '/storage_units/:id', to: 'storage_units#show'
  get '/storage_units/:id/edit', to: 'storage_units#edit'
  patch '/storage_units/', to: 'storage_units#update'
  delete '/storage_units/:id', to: 'storage_units#destroy'

  get '/storage_units/:id/chemicals', to: 'storage_unit_chemicals#index'
  get '/storage_units/:id/chemicals/new', to: 'chemicals#new'
  post '/storage_units/:id/chemicals/', to: 'chemicals#create'

  get '/chemicals', to: 'chemicals#index'
  post '/chemicals', to: 'chemicals#create'
  get '/chemicals/new', to: 'chemicals#new'
  get '/chemicals/:id', to: 'chemicals#show'
  get '/chemicals/:id/edit', to: 'chemicals#edit'
  patch '/chemicals/', to: 'chemicals#update'
  delete '/chemicals/:id', to: 'chemicals#destroy'

end
