class Task < ActiveRecord::Base
  belongs_to :project
  has_many :subtasks, class_name: Task, foreign_key: :parent_task_id
  belongs_to :parent_task, class_name: Task
  has_many :comments
end
