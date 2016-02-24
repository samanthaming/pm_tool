class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index

  end

  def create
    project = Project.find params[:project_id]

    if is_author_of? project
      return redirect_to project, notice: "Access Denied"
    end

    favorite = Favorite.new(project: project, user: current_user)

    if favorite.save
      redirect_to project, notice: "Added Favorite"
    else
    redirect_to project, alert: "Error, Can't Favorite"
    end

  end

  def destroy
    project = Project.find params[:project_id]
    favorite = current_user.favorites.find params[:id]
    favorite.destroy
    redirect_to project_path(project), notice: "Un-favorited"
  end

end
