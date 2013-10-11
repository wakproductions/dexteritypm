module TasksHelper
  def task_status(task)
    Task::STATUS.key(task.status).to_s.capitalize if task.status
  end

  def task_category(task)
    Task::CATEGORY.key(task.category).to_s.capitalize if task.category
  end
end
