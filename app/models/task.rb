class Task < ActiveRecord::Base
  CATEGORY={
      feature: 1,
      todo: 2,
      bug: 3,
      aesthetic: 4,
      group: 100
  }

  STATUS={
      TBD: 1,
      planning: 10,
      pending: 20,
      in_process: 30,
      done: 40
  }

  belongs_to :project
  has_many :subtasks, class_name: Task, foreign_key: :parent_task_id
  belongs_to :parent_task, class_name: Task
  has_many :comments

  validates_presence_of :project

  scope :by_status, ->(status){ where(status: status) }

  # This assigns the project in the case that we do a call like:
  # @task = @project.tasks.find(x).subtasks.new
  after_initialize do |r|
    if new_record?
      r.project_id = parent_task.project_id if parent_task && project_id.nil?
    end
  end
end
