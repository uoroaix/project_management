class CommentsController < ApplicationController

  before_action :authenticate_user!


  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.new(comment_attributes)
    @comment.user = current_user
    if @comment.save
      redirect_to [@discussion.project, @discussion], notice: "comments submmited"
    else
      render :new, alert: "error occurred"
    end
  end


  def new
    @discussion = Discussion.find(params[:discussion_id])
    @comment = Comment.new
    
  end

  def destroy
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.find(params[:id])
    if @comment.destroy
      redirect_to [@discussion.project, @discussion], alert: "comment deleted!"
    end
  end


  private

  def comment_attributes
    params.require(:comment).permit([:body])
  end


end
