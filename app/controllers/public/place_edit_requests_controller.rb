class Public::PlaceEditRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @place = Place.find(params[:place_id])
    @place_edit_request = PlaceEditRequest.new(place: @place)

    @place_edit_request.name = @place.name
    @place_edit_request.category = @place.category
    @place_edit_request.nursery = @place.nursery
    @place_edit_request.diaper = @place.diaper
    @place_edit_request.kids_toilet = @place.kids_toilet
    @place_edit_request.stroller = @place.stroller
    @place_edit_request.playground = @place.playground
    @place_edit_request.shade = @place.shade
    @place_edit_request.bench = @place.bench
    @place_edit_request.elevator = @place.elevator
    @place_edit_request.parking = @place.parking

  end

  def create
    @place = Place.find(params[:place_id])
    @place_edit_request = current_user.place_edit_requests.build(place_edit_request_params)
    @place_edit_request.place = @place

    if @place_edit_request.save
      redirect_to public_place_path(@place), notice: "編集リクエストを送信しました。"
    else
      flash.now[:alert] = "編集リクエストの送信に失敗しました。"      
      render :new
    end
  end

  private

    def place_edit_request_params
      params.require(:place_edit_request).permit(:name, :category, :nursery, :diaper, :kids_toilet, :stroller, :playground, :shade, :bench, :elevator, :parking, photos: [])
    end
    
end
