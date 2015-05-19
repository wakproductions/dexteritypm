class MoveTask
  include Interactor

  def call
    task = context.task
    new_parent_task = context.to_task

    if task.project != new_parent_task.project
      context.fail!(error: "Cannot move task to another project.")
    elsif task.id == new_parent_task.id
      context.fail!(error: "Cannot move a task to become a child of itself.")
    else
      context.success = task.update(parent_task: new_parent_task)
    end

  end
end