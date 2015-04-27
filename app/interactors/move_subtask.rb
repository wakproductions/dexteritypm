class MoveSubtask
  include Interactor

  def call
    task = context.task
    new_parent_task = context.to_task

    if task.project != new_parent_task.project
      context.fail!(error: "Cannot move task to another project.")
    elsif task.parent_task.present? && !task.parent_task.group? && task.parent_task != new_parent_task
      context.fail!(error: "Cannot move a subtask to become the subtask of another task")
    else
      task.update(parent_task: new_parent_task)
    end

  end
end