class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_places = current_user.bookmarked_places.includes(:bookmarks)
  end

  def create
    @place = Place.find(params[:place_id])
    @bookmark = current_user.bookmarks.create(place: @place)
    redirect_to public_place_path(@place)
  end

  def destroy
    @place = Place.find(params[:place_id])
    @bookmark = current_user.bookmarks.find_by(place: @place)
    @bookmark.destroy if @bookmark
    redirect_to public_place_path(@place)
  end 
end
