class Admin::PlaceEditRequestsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @place_edit_requests = PlaceEditRequest.includes(:user, :place).order(created_at: :desc)
  end

  def show
    @place_edit_request = PlaceEditRequest.find(params[:id])
    @place = @place_edit_request.place
  end

  def update
    @place_edit_request = PlaceEditRequest.find(params[:id])
    @place = @place_edit_request.place
    
    if @place_edit_request.update_column(status, params[:status])
      if @place_edit_request.status == "approved"
        @place_edit_request.update_place
      end
      redirect_to admin_place_edit_request_path(@place_edit_request), notice: "ステータスを更新しました。"
    else
      render :show, alert: "更新に失敗しました。"
    end
  end

  private

end
