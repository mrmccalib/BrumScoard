Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    get 'index' => 'sessions#new'
    get '/' => 'sessions#new'


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
    post '/boards/join',   to: 'boards#join'
    post '/boards/reject', to: 'boards#reject'

    get '/boards/:id/sort', to: 'boards#list_update'

    get  '/boards/:id/newstory',          to: 'stories#new',    as: 'newstory'
    post '/boards/:id/newstory',          to: 'stories#create'
    get  '/boards/:id/stories/:story_id', to: 'stories#edit',   as: 'editstory'
    post '/boards/:id/stories/:story_id', to: 'stories#update'
    get 'story/show'

    get  '/boards/:id/stories/:story_id/newtask', to: 'tasks#new',    as: 'newtask'
    post '/boards/:id/stories/:story_id/newtask', to: 'tasks#create'
    get  '/boards/:id/stories/:story_id/tasks/:task_id', to: 'tasks#edit',    as: 'edittask'
    post '/boards/:id/stories/:story_id/tasks/:task_id', to: 'tasks#update'

end
