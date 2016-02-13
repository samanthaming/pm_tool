module TasksHelper

  def task_done_button(project, task)
    text = task.done? ? "Undone" : "Done"
    button_to text, mark_done_task_path({id: task, project_id: project}), method: :patch
  end


end
