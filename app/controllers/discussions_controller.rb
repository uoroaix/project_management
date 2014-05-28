class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_discussion, only: [:show, :edit, :destroy, :update]


  def index
  end

  def create
    @project = Project.find params[:project_id]
    @discussion = @project.discussions.new(discussion_attributes)
    @discussion.user = current_user
    if @discussion.save
      redirect_to @project, notice: "Discussion Created Succefully!"
    else
      render :new, alert: "Something was wrong, please try again."
    end
  end

  def new
    @project = Project.find params[:project_id]
    @discussion = Discussion.new
  end

  def update
  end

  def edit
  end

  def show
  end

  def destroy
    if @discussion.destroy
      redirect_to @project, notice: "Discussion Deleted!"
    else
      redirect_to @project, alert: "Some error occured, please contact admin!"
    end
  end


  private

  def discussion_attributes
    params.require(:discussion).permit([:title, :description])
  end

  def find_discussion
    @project = Project.find(params[:project_id])
    @discussion = @project.discussions.find(params[:id])
  end   

end
