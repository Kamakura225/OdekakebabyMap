class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_many :likes, as: :likeable, dependent: :destroy # コメントにもいいね可能

  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true
end
