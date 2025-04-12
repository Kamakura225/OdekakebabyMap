class Place < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  has_many_attached :photos

  enum category: { park: 0, facility: 1 } # 公園か施設かの分類
  enum status: { pending: 0, approved: 1 }

  # has_many :place_features, dependent: :destroy
  has_many :features, through: :place_features
  

  validates :name, :address, :latitude, :longitude, presence: true
  validates :nursery, :diaper, :kids_toilet, :stroller, :playground, :shade, :bench, 
            :elevator, :parking, inclusion: { in: [true, false] }
  geocoded_by :address
  after_validation :geocode

  # 緯度と経度のカラムを追加するためのマイグレーション
  # t.float :latitude
  # t.float :longitude

  def main_image_url
    if photos.attached?
      Rails.application.routes.url_helpers.rails_blob_url(photos.first, only_path: true)
    else
      nil
    end
  end

  def comments_count
    comments.count
  end

  def likes_count
    likes.count
  end

  def facility_summary
    facilities = []
    facilities << "授乳室あり" if nursery
    facilities << "おむつ交換台あり" if diaper
    facilities << "遊具あり" if playground
    facilities << "駐車場あり" if parking
    facilities.join("・")
  end

  def place_path
    Rails.application.routes.url_helpers.public_place_path(self)
  end
end

