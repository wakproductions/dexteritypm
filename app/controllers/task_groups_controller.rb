class TaskGroupsController < ApplicationController
  before_action :authenticate_user!

  # GET project/:project_id/groups/new
  def new
    @task_group = Task.new(project_id: params[:project_id], group: true)
  end

  # POST project/:project_id/groups
  def create
    result = CreateTaskGroup.call(task_group_params.merge({project_id: params[:project_id]}))
    @task_group = result.task_group

    if result.success?
      redirect_to project_tasks_path(params[:project_id]), notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  private

  def task_group_params
    params.require(:task_group).permit(:title)
  end

end
