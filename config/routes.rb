Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  ## CRUD: Projects

  # Create
  # get "/projects/new" => "projects#new", as: :new_project
  # post "/projects" => "projects#create", as: :projects
  #
  # # Read
  # get "/projects" => "projects#index", as: :projects
  # get "/projects/:id" => "projects#show"
  #
  # # Update
  # get "/projects/:id/edit" => "projects#edit", as: :edit_project
  # patch '/projects/:id' => "projects#update"
  #
  # # Destroy
  # delete "/projects/:id" => "projects#Destroy"


  resources :projects do
    resources :tasks, only: [:create, :destroy]
  end

  patch "/projects/:id/mark_done" => "tasks#mark_done", as: :mark_done_task


  ## CRUD: Tasks

  # Create
  # get "/tasks/new" => "tasks#new", as: :new_task
  # post "/tasks" => "tasks#create", as: :tasks
  #
  # # Read
  # get "/tasks" => "tasks#index"
  # get "/tasks/:id" => "tasks#show", as: :task
  #
  # # Update
  # get "/tasks/:id/edit" => "tasks#edit", as: :edit_task
  # patch "/tasks/:id" => "tasks#update"
  #
  # # Destroy
  # delete "/tasks/:id" => "tasks#destroy"

  # resources :tasks
end
