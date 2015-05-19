class Task < ActiveRecord::Base
  CATEGORY={
      feature: 1,
      todo: 2,
      bug: 3,
      aesthetic: 4,
      technical: 5,
      group: 100  # to be deprecated
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
  validates_presence_of :title
  validates_absence_of :parent_task, if: :group?

  scope :by_status, ->(status){ where(status: status) }

  # This assigns the project in the case that we do a call like:
  # @task = @project.tasks.find(x).subtasks.new
  after_initialize do |r|
    if new_record?
      r.project_id = parent_task.project_id if parent_task && project_id.nil?
    end
  end

  def group?
    group || category == CATEGORY[:group]
  end

  # Returns a hash which can be converted to JSON for use with the jsTree view component.
  # Consider putting this into a decorator at a later time.
  def to_jsTree
    result = { id: id, text: title }
    result[:children] = subtasks.map { |subtask| subtask.to_jsTree } if subtasks.count > 0
    result
  end
end
