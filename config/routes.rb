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


  resources :projects

end
