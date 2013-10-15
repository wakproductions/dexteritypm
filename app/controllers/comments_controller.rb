class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:create]

  # POST /projects/:project_id/tasks/:task_id/comments
  def create
    @comment = Comment.new(comment_params.merge({user: current_user, task_id: params[:task_id]}))
    @comment.save
    redirect_to project_task_path(@project, @task)

    #respond_to do |format|
    #
    #  if @comment.save
    #    format.html { redirect_to project_task_path(@project, @task) }
    #  else
    #    format.html { render action: 'new' }
    #  end
    #end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id]) if @project
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body)
  end

end
