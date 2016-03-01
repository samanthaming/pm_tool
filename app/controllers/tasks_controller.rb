class TasksController < ApplicationController


  def create
    @project = Project.find params[:project_id]
    @task = Task.new task_params
    @task.project = @project

    respond_to do |format|
      if @task.save
        format.html{redirect_to project_path(@project), notice: "Task Created"}
        format.js { render :create_success }
      else
        format.html{render "/projects/show"}
        format.js { render :create_failure }
      end
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    @task.destroy

    respond_to do |format|
      format.html{redirect_to project_path(@project), notice: "Task Deleted"}
      format.js { render } #this renders /views/tasks/destroy.js.erb
    end
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
