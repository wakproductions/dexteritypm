class API::TasksController < ApplicationController
  before_action :authenticate_user!

  # GET /api/projects/:project_id/tasks
  def index
    # if params[:parent_task_id].present?
    #   project = Project.includes(:tasks).find_by(id: params[:project_id])
    #   if project
    #     @task_list = project.tasks.find_by(id: params[:parent_task_id]).subtasks
    #   else
    #     @task_list = []
    #   end
    # else
    #   @task_list = Project.find_by(id: params[:project_id]).tasks
    # end

    @task_list = fetch_task_list
    render json: @task_list
  end

  def jstree
    @task_list = fetch_task_list.map { |task| task.to_jsTree }
    set_jstree_selected!(@task_list, params[:selected_task_id].to_i) if params[:selected_task_id].present?
    render json: @task_list
  end

  private

  def fetch_task_list
    project = current_user.projects.find_by(id: params[:project_id])

    if params[:parent_task_id].present?
      if project
        @task_list = project.tasks.find_by(id: params[:parent_task_id]).subtasks
      else
        @task_list = []
      end
    else
      if project
        @task_list = project.tasks.where(parent_task_id: nil)
      else
        @task_list = []
      end
    end
  end

  def set_jstree_selected!(jstree_task_list, id)
    jstree_task_list.each do |jtree_task|
      jtree_task[:state] = { selected: true} if jtree_task[:id] == id
      set_jstree_selected!(jtree_task[:children], id) if jtree_task.has_key? :children
    end
  end

end
