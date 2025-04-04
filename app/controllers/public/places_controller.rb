class Public::PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # ログインユーザーのみアクセス

  def index
    @places = Place.all # 施設・公園の一覧
  end

  def show
    @place = Place.find(params[:id]) # 施設・公園の詳細
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.build(place_params)
    if @place.save
      redirect_to public_place_path(@place), notice: '施設・公園が追加されました！'
    else
      render :new
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to public_place_path(@place), notice: '施設・公園が更新されました！'
    else
      render :edit
    end
  end

  # def destroy
    # @place = Place.find(params[:id])
    # @place.destroy
    # redirect_to public_places_path, notice: '施設・公園が削除されました！'
  # end

  private

  def place_params
    params.require(:place).permit(:name, :address, :category, :latitude, :longitude, :image, feature_ids: [])
  end
end
