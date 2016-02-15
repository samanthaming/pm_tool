class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :destroy, :update]

  # CREATE

  def new
    @project = Project.new
  end

  def create
    # project_params = params.require(:project).permit(:name, :description, :due_date)
    @project = Project.new project_params

    if @project.save
      redirect_to project_path(@project), notice: "Project created successfully"
    else
      flash[:alert] = "Project wasn't created"
      render :new
    end
  end

  # READ
  def index
    @projects = Project.order("id DESC").page params[:page]
  end

  def show
    # @project = Project.find params[:id]
    @task = Task.new
    @discussion = Discussion.new
  end

  # Update
  def edit
    # @project = Project.find params[:id]
  end

  def update
    # @project = Project.find params[:id]
    if @project.update project_params
      redirect_to project_path(@project), notice: "Project updated successfully"
    else
      flash[:alert] = "Project not updated successfully"
      render :edit
    end
  end

  # Destroy
  def destroy
    # @project = Project.find params[:id]
    @project.destroy

    redirect_to projects_path, notice: "Project Destroyed"
  end

  private

  def project_params
    params.require(:project).permit(:title,:description,:due_date)
  end

  def find_project
    @project = Project.find params[:id]
  end
end
