class Public::CommentsController < ApplicationController
  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to public_place_path(@place), notice: 'コメントが投稿されました！'
    else
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

  def comment_params
    params.require(:comment).permit(:content)
  end
end