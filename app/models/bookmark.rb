class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :place

  validates :user_id, uniqueness: { scope: :place_id }
end
