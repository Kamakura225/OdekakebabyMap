class Public::PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # ログインユーザーのみアクセス
  before_action :set_place, only: [:show]

  def index
    @places = Place.where(status: :approved).includes(:comments, :likes, photos_attachments: :photos_blobs) # 施設・公園の一覧
  end

  def show
    @place = Place.find(params[:id]) # 施設・公園の詳細
    @place.comments.build
    @comments = @place.comments.includes(:user)
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.build(place_params)
    # @place.status = :pending # デフォルトは承認待ち
    @place.status = :approved

    if @place.save
      redirect_to public_place_path(@place), notice: "施設を投稿しました（承認待ち）"
    else
      flash.now[:alert] = "投稿に失敗しました。"
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
      render :new
    end
  end

  def destroy
    @place = Place.find(params[:id])
    
    if @place.user == current_user
      @place.destroy
      redirect_to public_places_path, notice: '施設・公園が削除されました！'
    else
      redirect_to public_place_path(@place), alert: '削除権限がありません'
    end
  end

  private

  def place_params
    params.require(:place).permit(
      :name, :category, :address, :latitude, :longitude,
      :nursery, :diaper, :kids_toilet, :stroller, :playground,
      :shade, :bench, :elevator, :parking, :status,
      photos: []
    )
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
