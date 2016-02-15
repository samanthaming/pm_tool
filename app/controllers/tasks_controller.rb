class TasksController < ApplicationController


  def create
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


end
