class Public::PlaceDeleteRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place

  def new
    @place_delete_request = PlaceDeleteRequest.new
  end

  def create
    @place_delete_request = @place.place_delete_requests.build(place_delete_request_params)
    @place_delete_request.user = current_user
    if @place_delete_request.save
      redirect_to place_path(@place), notice: "削除リクエストを送信しました。"
    else
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def place_delete_request_params
    params.require(:place_delete_request).permit(:reason)
  end
end
