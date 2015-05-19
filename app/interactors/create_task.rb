class CreateTask
  include Interactor

  def call
    task_attributes = context.task_attributes

    project = Project.find_by(id: task_attributes[:project_id])
    context.fail!(errors: ['A task requires a project to be created.']) if project.nil?

    if context.task_attributes[:parent_task_id]
      context.task = project.tasks.find(task_attributes[:parent_task_id]).subtasks.new(task_attributes)
    else
      context.task = project.tasks.new(task_attributes)
    end

    unless context.task.save
      context.fail!(errors: context.task.errors)
    end
  end

  private

end