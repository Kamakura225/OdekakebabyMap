class Public::CommentsController < ApplicationController
  before_action :authenticate_user!  # コメント投稿はログイン必須
  before_action :set_place

  def create
    @comment = @place.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      # コメントが保存されたら、部分テンプレートで表示を更新
      respond_to do |format|
        format.html { redirect_to public_place_path(@place), notice: "コメントを投稿しました。" }
        format.js
      end
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