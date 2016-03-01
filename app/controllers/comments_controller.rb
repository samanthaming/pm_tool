class CommentsController < ApplicationController
  before_action :find_discussion_and_get_project, only: [:create, :destroy]
  def create
    # @discussion = Discussion.find params[:discussion_id]
    # @project = @discussion.project
    @comment = Comment.new comment_params
    @comment.discussion = @discussion

    respond_to do |format|
      if @comment.save
        format.html {redirect_to project_discussions_path(@project), notice: "Comment Created"}
        format.js { render :create_success }
      else
        format.html{
          flash[:alert] = "Comment not created"
          render "/discussions/index"
        }
        format.js { render :create_failure }
      end
    end
  end


  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy

    respond_to do |format|
      format.html{redirect_to project_discussions_path(@project), notice: "Comment Removed"}
      format.js { render } # this renders /views/comments/destroy.js.erb
    end
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
