class Admin::PlaceDeleteRequestsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_place_delete_request, only: [:show, :update]

  def index
    @place_delete_requests = PlaceDeleteRequest.all.includes(:place).order(created_at: :desc)
  end

  def show
  end

  def update
    case params[:decision]
    when "approve"
      @place_delete_request.update(status: :approved)
      @place_delete_request.place.destroy
      flash[:notice] = "削除リクエストを承認し、施設を削除しました。"
    when "reject"
      @place_delete_request.update(status: :rejected)
      flash[:alert] = "削除リクエストを却下しました。"
    end
    redirect_to admin_place_delete_requests_path
  end

  private

  def set_place_delete_request
    @place_delete_request = PlaceDeleteRequest.find(params[:id])
  end
end

