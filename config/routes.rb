Rails.application.routes.draw do
  resources :actors
  # post '/actors/create', to: 'actors#create'
  # patch '/actors/:id/update', to: 'actors#update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "actors#index"
end
