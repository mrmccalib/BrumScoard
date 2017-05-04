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
    get  '/boards',                                         to: 'boards#index'
    get  '/boards/:id/states/:state_id/sprints/:sprint_id', to: 'boards#show',           as: 'board'
    get  '/newboard',                                       to: 'boards#new'
    post '/newboard',                                       to: 'boards#create'
    get  '/boards/:id/invite',                              to: 'boards#invite',         as: 'invite'
    post '/boards/:id/invite',                              to: 'boards#send_invitation'
    post '/boards/join',                                    to: 'boards#join'
    post '/boards/reject',                                  to: 'boards#reject'

    get '/boards/:id/states/:state_id/sprints/:sprint_id/sortstories', to: 'boards#stories_update'
    get '/boards/:id/states/:state_id/sprints/:sprint_id/sorttasks',   to: 'boards#tasks_update'

    get  '/boards/:id/states/:state_id/sprints/:sprint_id/newstory',                 to: 'stories#new',      as: 'newstory'
    post '/boards/:id/states/:state_id/sprints/:sprint_id/newstory',                 to: 'stories#create'
    get  '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id',        to: 'stories#edit',     as: 'editstory'
    post '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id',        to: 'stories#update'
    get  '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/accept', to: 'stories#accept',   as: 'acceptstory'
    get  '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/reject', to: 'stories#reject',   as: 'rejectstory'
    post '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/reject', to: 'stories#do_reject'

    get    '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/newtask',               to: 'tasks#new',     as: 'newtask'
    post   '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/newtask',               to: 'tasks#create'
    get    '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/tasks/:task_id',        to: 'tasks#edit',    as: 'edittask'
    post   '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/tasks/:task_id',        to: 'tasks#update'
    delete '/boards/:id/states/:state_id/sprints/:sprint_id/stories/:story_id/tasks/:task_id/delete', to: 'tasks#destroy', as: 'deletetask'

    post '/boards/:id/states/:state_id/sprints/:sprint_id/newsprint', to: 'sprints#create'

    post '/boards/:id/states/:state_id/sprints/:sprint_id/newstate',  to: 'states#create'

    get  '/boards/:id/states/:state_id/latestsprint',  to: 'states#latest_sprint'

    get  '/boards/:id/states/:state_id/memberships/:membership_id', to: 'memberships#show', as: 'member'

end
