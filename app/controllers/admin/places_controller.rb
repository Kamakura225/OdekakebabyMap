class Admin::PlacesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @places = Place.all # 施設・公園の一覧
  end

  def show
    @place = Place.find(params[:id]) # 施設・公園の詳細
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to admin_places_path, notice: '施設・公園が削除されました！'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: '管理者以外アクセスできません' unless current_user.admin?
  end
end