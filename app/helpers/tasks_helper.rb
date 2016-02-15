module TasksHelper

  def task_done_button(project, task)
    text = task.done? ? "Undone" : "Done"
    button_to text, mark_done_task_path(project, task), method: :patch
  end


end
