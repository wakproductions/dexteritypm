class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update]
  before_action :set_user_projects

  # GET /projects/:project_id/tasks
  def index
    @project = Project.find(params[:project_id])
    update_user_default_project(@project) if @project
    @filter = task_list_filter
    if @filter && @filter.include?(:status)
      @tasks = @project.tasks.by_status(@filter[:status]).where(parent_task_id: nil) if @project.tasks.present?
    else
      @tasks = @project.tasks.where(parent_task_id: nil) if @project.tasks.present?
    end
  end

  # GET /projects/:project_id/tasks/new
  def new
    @project = Project.find(params[:project_id])
    if params[:parent_task_id]
      @task = Project.find(@project).tasks.find(params[:parent_task_id]).subtasks.new
    else
      @task = Project.find(@project).tasks.new
    end
  end

  # POST /projects/:project_id/tasks
  def create
    @project = Project.find(params[:project_id])
    if params[:task][:parent_task_id]
      @task = @project.tasks.find(params[:task][:parent_task_id]).subtasks.new(task_params)
    else
      @task = @project.tasks.new(task_params)
    end

    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render action: 'new'
    end
  end

  # GET /projects/:project_id/tasks/:task_id
  def show
  end

  # GET /projects/:project_id/tasks/:task_id/edit
  def edit
  end

  # PATCH/PUT /projects/:project_id/tasks/:id
  def update
    if @task.update(task_params)
      redirect_to [@project, @task], notice: 'Task successfully updated.'
    else
      render 'edit'
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) if @project
    @comments = @task.comments.order('id DESC')
    @comment = Comment.new
  end

  # build a list of projects available for the user
  def set_user_projects
    @user_projects = current_user.projects.to_a - [@project]
  end

  def task_params
    params.require(:task).permit(:title, :category, :status, :description)
  end

  def task_list_filter
    @filter = params[:filter]
  end

  def update_user_default_project(project)
    current_user.update(default_project: project)
  end

end
