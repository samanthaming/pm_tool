Rails.application.routes.draw do

  root 'home#index'
  get '/about' => 'home#about'

  resources :projects do
    resources :tasks, only: [:create, :destroy]
    resources :discussions, only: [:create, :destroy, :index, :edit, :update]
  end

  patch "/projects/:project_id/mark_done/:id" => "tasks#mark_done", as: :mark_done_task

  resources :discussions, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:create, :new, :edit, :update, :show]
  get "/password" => "users#edit_password", as: :edit_password
  patch "/password" => "users#update_password", as: :update_password


  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
