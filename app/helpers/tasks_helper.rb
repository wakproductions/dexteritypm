module TasksHelper
  def task_status(task)
    Task::STATUS.key(task.status).to_s.capitalize if task.status
  end

  def task_category(task)
    Task::CATEGORY.key(task.category).to_s.capitalize if task.category
  end

  def task_status_class(status)
    case status
      when Task::STATUS[:pending], Task::STATUS[:in_process]
        'task-status-yellow'
      when Task::STATUS[:done]
        'task-status-green'
    end
  end

  def subtasks_by_status(task)
    if @filter && @filter.include?(:status)
      task.subtasks.by_status(@filter[:status])
    else
      task.subtasks
    end
  end
end
