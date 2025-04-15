class Public::CommentsController < ApplicationController
  before_action :authenticate_user!  # コメント投稿はログイン必須
  before_action :set_place

  def create
    @place = Place.find(params[:place_id])
    @comment = current_user.comments.new(comment_params)
    @comment.place_id = @place.id
    if @comment.save
      redirect_to place_path(@place), notice: "コメントを投稿しました"
    else
      @comments = @place.comments.includes(:user)
      
      flash.now[:alert] = "コメントの投稿に失敗しました。"
      render 'public/places/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @place = @comment.place
    @comment.destroy
    redirect_to public_place_path(@place), notice: 'コメントが削除されました！'
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :rating)
  end
end