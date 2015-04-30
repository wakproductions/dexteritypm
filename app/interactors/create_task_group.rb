class CreateTaskGroup
  include Interactor

  def call
    context.task_group = Task.new(build_attributes)

    unless context.task_group.save
      context.fail!(errors: context.task_group.errors)
    end
  end

  private

  def build_attributes
    attr = Hash.new
    attr[:title] = context.title
    if context.project
      attr[:project] = context.project
    else
      attr[:project_id] = context.project_id
    end
    attr[:group] = true
    attr
  end
end