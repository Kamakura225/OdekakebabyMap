class Public::PlacesController < ApplicationController
  before_action :authenticate_user!

  def index    
    @places = Place.where(status: :approved).where.not(latitude: nil, longitude: nil)
  
    # カテゴリフィルター
      categories = []
      categories << "park" if params[:category_park].present?
      categories << "facility" if params[:category_facility].present?
      @places = @places.where(category: categories) if categories.any?
  
    # 設備条件（booleanカラム）
      [:nursery, :diaper, :kids_toilet, :stroller, :playground, :shade, :bench, :elevator, :parking].each do |key|
        @places = @places.where(key => true) if params[key].present?
      end  
    
    @places = @places.includes(:comments, :likes, photos_attachments: :blob)
  
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @place = Place.find(params[:id]) # 施設・公園の詳細
    @comments = @place.comments.includes(:user, :likes)
    @comment = Comment.new

    approved_comments = @place.comments.where.not(rating: nil)
    @average_rating = if approved_comments.any?
                        (approved_comments.average(:rating).round(1) rescue nil)
                      else
                        nil
                      end
  end

  # ゲストユーザーがアクセスできないアクションを制限
  def new
    redirect_to places_path, alert: 'ゲストユーザーは施設の登録ができません' if guest_user?
    @place = Place.new
  end

  def create
    redirect_to places_path, alert: 'ゲストユーザーは施設の登録ができません' if guest_user?
    @place = current_user.places.build(place_params)
    @place.status = :pending # デフォルトは承認待ち
    
    if @place.save
      redirect_to place_path(@place), notice: "施設を投稿しました（承認待ち）"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  

  private

  def place_params
    params.require(:place).permit(
      :name, :address, :latitude, :longitude, :category, :status,
      :nursery, :diaper, :kids_toilet, :stroller,
      :playground, :shade, :bench, :elevator, :parking,
      photos: []
    )
  end  
  
end
