class TasksController < ApplicationController

  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    # task_params = params.require(:task).permit(:title, :due_date)
    @task = Task.new task_params

    if @task.save
      redirect_to task_path(@task), notice: "Task created successfully"
    else
      flash[:alert] = "Task wasn't created"
      render :new
    end
  end

  def index
    @task = Task.order("id DESC")
  end

  def show
    # @task = Task.find params[:id]
  end

  def edit
    # @task = Task.find params[:id]
  end

  def update
    # @task = Task.find params[:id]
    task_params = params.require(:task).permit(:title, :due_date)

    if @task.update task_params
      redirect_to task_path(@task), notice: "Task updated succesfully"
    else
      flush[:alert] = "Task not updated"
      render :edit
    end
  end

  def destroy
    # @task = Task.find params[:id]
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted"
  end

  private

  def task_params
    task_params = params.require(:task).permit(:title, :due_date)
  end

  def find_task
    @task = Task.find params[:id]
  end

end
