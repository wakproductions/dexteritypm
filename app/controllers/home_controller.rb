class HomeController < ApplicationController
  before_action :authenticate_user!

  # GET /
  def index
    redirect_to(project_tasks_path(default_project)) if default_project.present?
  end


private

  def default_project
    current_user.default_project ||= current_user.projects.first
  end

end
