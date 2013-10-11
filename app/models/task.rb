class Task < ActiveRecord::Base
  CATEGORY={
      feature: 1,
      todo: 2,
      bug: 3,
      aesthetic: 4,
      group: 100
  }

  STATUS={
      pending: 1,
      in_process: 2,
      done: 3
  }

  belongs_to :project
  has_many :subtasks, class_name: Task, foreign_key: :parent_task_id
  belongs_to :parent_task, class_name: Task
  has_many :comments
end
