class TasksController < ApplicationController


  def create
    # render json: params
    @project = Project.find params[:project_id]
    @task = Task.new task_params
    @task.project = @project

    if @task.save
      redirect_to project_path(@project), notice: "Task Created"
    else
      render "/projects/show"
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    @task.destroy
    redirect_to project_path(@project), notice: "Task Deleted"
  end

  def mark_done
      @project = params[:project_id]
      @task = Task.find params[:id]
      @task.done = !@task.done
      @task.save
      redirect_to project_path(@project)
  end

  private

  def task_params
    task_params = params.require(:task).permit(:body, :title, :due_date)
  end

  # before_action :find_task, only: [:show, :edit, :update, :destroy]
  #
  # def new
  #   @task = Task.new
  # end
  #
  # def create
  #   # task_params = params.require(:task).permit(:title, :due_date)
  #   @task = Task.new task_params
  #
  #   if @task.save
  #     redirect_to task_path(@task), notice: "Task created successfully"
  #   else
  #     flash[:alert] = "Task wasn't created"
  #     render :new
  #   end
  # end
  #
  # def index
  #   @task = Task.order("id DESC")
  # end
  #
  # def show
  #   # @task = Task.find params[:id]
  # end
  #
  # def edit
  #   # @task = Task.find params[:id]
  # end
  #
  # def update
  #   # @task = Task.find params[:id]
  #   task_params = params.require(:task).permit(:title, :due_date)
  #
  #   if @task.update task_params
  #     redirect_to task_path(@task), notice: "Task updated succesfully"
  #   else
  #     flush[:alert] = "Task not updated"
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   # @task = Task.find params[:id]
  #   @task.destroy
  #   redirect_to tasks_path, notice: "Task deleted"
  # end
  #
  # private
  #
  # def task_params
  #   task_params = params.require(:task).permit(:title, :due_date)
  # end
  #
  # def find_task
  #   @task = Task.find params[:id]
  # end

end
