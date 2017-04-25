Rails.application.routes.draw do

  get 'packages/new'

  get 'sessions/new'

  root 'static_pages#home'

  get  '/openscadpm',    to: 'static_pages#OpenScadpm'

  get  '/documentation',    to: 'static_pages#Documentation'



  get  '/support',    to: 'static_pages#Support'

  get  '/mypackages',    to: 'static_pages#MyPackages'

  get  '/signup', to: 'users#new'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  get '/newpackage', to: 'packages#new' 

  post '/newpackage', to: 'packages#create'

  resources :users

  resources :packages

end
