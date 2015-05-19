class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_projects, only: [:index]

  # GET /projects/:project_id/tasks
  def index
    set_project
    update_user_default_project(@project) if current_user.default_project != @project
    @filter = task_list_filter
    if @filter && @filter.include?(:status)
      @tasks = @project.tasks.by_status(@filter[:status]).where(parent_task_id: nil) if @project.tasks.present?
    else
      @tasks = @project.tasks.where(parent_task_id: nil) if @project.tasks.present?
    end
  end

  # GET /projects/:project_id/tasks/new
  def new
    set_project
    if params[:parent_task_id]
      @task = Project.find(@project.id).tasks.find(params[:parent_task_id]).subtasks.new
    else
      @task = Project.find(@project.id).tasks.new
    end
  end

  # POST /projects/:project_id/tasks
  def create
    set_project

    result = CreateTask.call(task_attributes: task_params.merge({project_id: @project.id}))
    @task = result.task

    if result.success?
      flash[:notice] = 'Task was successfully created.'
      redirect_to project_task_path(project_id: @project.id, id: @task.id)
    else
      render action: 'new'
    end
  end

  # GET /projects/:project_id/tasks/:task_id
  def show
    set_project && set_task && set_comments
  end

  # GET /projects/:project_id/tasks/:task_id/edit
  def edit
    set_project && set_task && set_comments
  end

  # PATCH/PUT /projects/:project_id/tasks/:id
  def update
    set_project && set_task
    if @task.update(task_params)
      redirect_to [@project, @task], notice: 'Task successfully updated.'
    else
      render 'edit'
    end
  end

  # GET /projects/:project_id/tasks/:task_id/move
  def move
    set_project && set_task
    @selected_task = @task
  end

  # PUT /projects/:project_id/tasks/:task_id/move
  def move_action
    set_project && set_task
    to_task = @project.tasks.find_by(id: params[:to_task_id])

    result = MoveTask.call(task: @task, to_task: to_task)

    if result.success?
      redirect_to project_task_path(project_id: @project.id, id: @task.id), notice: 'Task was successfully moved.'
    else
      @selected_task = @task
      render action: 'move'
    end
  end

  private

  def set_project
    @project = current_user.projects.find_by(id: params[:project_id])

    # TODO: insert error handling here if no project is found
  end

  def set_task
    @task = @project.tasks.find(params[:id] || params[:task_id]) if @project
  end

  def set_comments
    @comments = @task.comments.order('id DESC')
    @comment = Comment.new
  end

  # Generates the list of projects the user could switch to
  def set_user_projects
    @user_projects = current_user.projects.to_a - [@project]
  end

  def task_params
    params.require(:task).permit(:title, :category, :status, :description, :parent_task_id)
  end

  def task_list_filter
    @filter = params[:filter]
  end

  def update_user_default_project(project)
    current_user.update(default_project: project)
  end

end
