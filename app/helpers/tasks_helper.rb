module TasksHelper
  SUBTASK_INDENT=15

  def task_status(task)
    Task::STATUS.key(task.status).to_s.capitalize if task.status && task.category != Task::CATEGORY[:group]
  end

  def task_category(task)
    Task::CATEGORY.key(task.category).to_s.capitalize if task.category && task.category != Task::CATEGORY[:group]
  end

  def task_status_class(status)
    case status
      when Task::STATUS[:pending], Task::STATUS[:in_process]
        'task-status-yellow'
      when Task::STATUS[:done]
        'task-status-green'
    end
  end

  def task_row_class(task)
    'task-category-group' if task.group?
  end

  def subtasks_by_status(task)
    if @filter && @filter.include?(:status)
      task.subtasks.by_status(@filter[:status])
    else
      task.subtasks
    end
  end
end
