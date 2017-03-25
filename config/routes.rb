Rails.application.routes.draw do
  # get 'boards/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get 'index' => 'sessions#new'

    # resources :users
    get '/signup', to: 'users#new'
    post '/signup', to: 'users#create'

    # resources :sessions
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'

    resources :boards
    get 'burd', to: 'boards#new'
end
