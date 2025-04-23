class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    
    @comments = Comment.includes(:user, :place).order(created_at: :desc)

    case params[:sort]
    when 'good'
      @comments = @comments
        .left_joins(:likes)
        .where(likes: { reaction_type: :good })
        .group('comments.id')
        .order('COUNT(likes.id) DESC')
    when 'bad'
      @comments = @comments
        .left_joins(:likes)
        .where(likes: { reaction_type: :bad })
        .group('comments.id')
        .order('COUNT(likes.id) DESC')
    else
      @comments = @comments.order(created_at: :desc)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: "コメントを削除しました"
  end








end
