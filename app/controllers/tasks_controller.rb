class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update]

  # GET /projects/:project_id/tasks
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.where(parent_task_id: nil) if @project.tasks.present?
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

  # GET /projects/:project_id/tasks/new
  def create
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

    #respond_to do |format|
    #  if @tattoo_removal_request.update(tattoo_removal_request_params)
    #    format.html { redirect_to @tattoo_removal_request, notice: 'Tattoo removal request was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @tattoo_removal_request.errors, status: :unprocessable_entity }
    #  end
    #end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) if @project
    @comments = @task.comments.order('id DESC')
    @comment = Comment.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :category, :status, :description)
  end

end
