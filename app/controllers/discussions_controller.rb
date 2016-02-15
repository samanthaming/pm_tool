class DiscussionsController < ApplicationController
  before_action :find_project, only: [:create, :destroy, :index, :edit, :update]
  before_action :find_discussion, only: [:edit, :update, :destroy]
  before_action :new_comment, only: [:edit, :index]

  def create
    @discussion = Discussion.new discussion_params
    @discussion.project = @project

    if @discussion.save
      redirect_to project_discussions_path(@project), notice: "Discussion Created"
    else
      render :index
    end

  end

  def index
    @discussion = Discussion.new
  end

  def edit
    render :index
  end

  def update
    if @discussion.update discussion_params
      redirect_to project_discussions_path(@project), notice: "Disucssion updated"
    else
      flash[:alert] = "Discussion not updated"
      render :index
    end
  end


  def destroy
    @discussion.destroy
    redirect_to project_discussions_path(@project), notice: "Discussion Deleted"
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

  def find_project
    @project = Project.find params[:project_id]
  end

  def find_discussion
    @discussion = Discussion.find params[:id]
  end

  def new_comment
    @comment = Comment.new
  end
end
