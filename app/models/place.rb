class Place < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :place_tags, dependent: :destroy
  has_many :tags, through: :place_tags

  has_many_attached :photos

  enum category: { park: 0, facility: 1 } # 公園か施設かの分類
  enum status: { pending: 0, approved: 1, rejected: 2 }

  # has_many :place_features, dependent: :destroy
  has_many :features, through: :place_features
  

  validates :name, :address, :latitude, :longitude, presence: true
  geocoded_by :address
  after_validation :geocode


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
    "#{category}（#{address}）"
  end

  def place_path
    Rails.application.routes.url_helpers.public_place_path(self)
  end
end

