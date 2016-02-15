class CommentsController < ApplicationController
  before_action :find_discussion_and_get_project, only: [:create, :destroy]
  def create
    # @discussion = Discussion.find params[:discussion_id]
    # @project = @discussion.project
    @comment = Comment.new comment_params
    @comment.discussion = @discussion

    if @comment.save
      redirect_to project_discussions_path(@project), notice: "Comment Created"
    else
      flash[:alert] = "Comment not created"
      render "/discussions/index"
    end

  end


  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to project_discussions_path(@project), notice: "Comment Removed"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_discussion_and_get_project
    @discussion = Discussion.find params[:discussion_id]
    @project = @discussion.project
  end

end
