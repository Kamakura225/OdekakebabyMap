class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_places = current_user.bookmarked_places.includes(:category)
  end

  def create
    @place = Place.find(params[:place_id])
    @bookmark = @place.bookmarks.build(user: current_user)
    if @bookmark.save
      redirect_to public_place_path(@place), notice: 'ブックマークしました！'
    else
      render 'public/places/show'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @place = @bookmark.place
    @bookmark.destroy
    redirect_to public_place_path(@place), notice: 'ブックマークを解除しました！'
  end
end
