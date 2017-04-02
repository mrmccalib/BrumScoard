Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    get 'index' => 'sessions#new'

    # resources :users
    get  '/signup', to: 'users#new'
    post '/signup', to: 'users#create'

    # resources :sessions
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'

  #  resources :boards
    get  '/boards',            to: 'boards#index'
    get  '/boards/:id',        to: 'boards#show',   as: 'board'
    get  '/newboard',          to: 'boards#new'
    post '/newboard',          to: 'boards#create'
    get  '/boards/:id/invite', to: 'boards#invite', as: 'invite'
    post '/boards/:id/invite', to: 'boards#send_invitation'


    get  '/boards/:id/newstory', to: 'stories#new', as: 'newstory'
    # post '/boards/:id/newstory', to: 'stories#create' as: 'newstory'
    get 'story/show'

end
