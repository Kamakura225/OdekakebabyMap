class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
  

  enum reaction_type: { good: 0, bad: 1 }
  
  validates :reaction_type, presence: true
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id], message: "はすでにリアクション済みです" }
end
