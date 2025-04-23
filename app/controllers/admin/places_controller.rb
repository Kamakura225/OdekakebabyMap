class Admin::PlacesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @places = Place.all # 施設・公園の一覧
  end

  def show
    @place = Place.find(params[:id]) # 施設・公園の詳細
    @comments = @place.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to admin_places_path, notice: '施設・公園が削除されました！'
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to admin_place_path(@place), notice: 'ステータスを更新しました。'
    else
      flash.now[:alert] = 'ステータスの更新に失敗しました。'
      render :show
    end
  end

  private

  def place_params
    params.require(:place).permit(:status)
  end
end