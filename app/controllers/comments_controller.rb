class CommentsController < ApplicationController
  def new
    @comment = Comment.new(
      commentable_type: params[:commentable_type],
      commentable_id: params[:commentable_id],
      user: current_user,
    )
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    authorize @comment

    @comment.save
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :commentable_id,
      :commentable_type,
      :title,
      :body,
      :subject,
      :user_id,
      :parent_id,
      :lft,
      :rgt,
    )
  end
end
