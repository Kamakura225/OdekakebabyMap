class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_many :likes, as: :likeable, dependent: :destroy # コメントにもいいね可能
end
