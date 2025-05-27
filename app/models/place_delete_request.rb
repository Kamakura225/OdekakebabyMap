class PlaceDeleteRequest < ApplicationRecord
  belongs_to :user
  belongs_to :place

  validates :reason, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }
end
