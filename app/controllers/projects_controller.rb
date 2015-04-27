class ProjectsController < ApplicationController
  # GET /project/:id
  def show
    redirect_to project_tasks_path(project_id: params[:id])
  end
end
