class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @place = Place.find(params[:place_id])
    @like = @place.likes.build(user: current_user)
    if @like.save
      redirect_to public_place_path(@place), notice: 'いいねしました！'
    else
      render 'public/places/show'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @place = @like.likeable
    @like.destroy
    redirect_to public_place_path(@place), notice: 'いいねを取り消しました！'
  end
end
