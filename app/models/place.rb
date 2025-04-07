class Place < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  has_many_attached :images

  enum category: { park: 0, facility: 1 } # 公園か施設かの分類

  has_many :place_features, dependent: :destroy
  has_many :features, through: :place_features

  validates :name, :address, :latitude, :longitude, presence: true

  # 緯度と経度のカラムを追加するためのマイグレーション
  # t.float :latitude
  # t.float :longitude
end
