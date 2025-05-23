class Public::PlaceEditRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @place = Place.find(params[:place_id])
    @place_edit_request = PlaceEditRequest.new(place: @place)
  end

  def create
    @place = Place.find(params[:place_id])
    @place_edit_request = current_user.place_edit_requests.build(place_edit_request_params)
    @place_edit_request.place = @place

    if @place_edit_request.save
      redirect_to place_path(@place), notice: "編集リクエストを送信しました。"
    else
      flash.now[:alert] = "編集リクエストの送信に失敗しました。"
      render :new
    end
  end

  private

    def place_edit_request_params
      params.require(:place_edit_request).permit(:name, :address, :nursery, :diaper, :kids_toilet, :stroller, :playground, :shade, :bench, :elevator, :parking, photos: [])
    end
    
end
