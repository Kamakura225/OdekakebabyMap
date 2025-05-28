class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :places, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_places, through: :bookmarks, source: :place
  has_many :place_edit_requests, dependent: :destroy
  has_many :place_delete_requests, dependent: :destroy

  has_one_attached :profile_image

  validates :nickname, presence: true,unless: :guest_user?
  
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
    user.password = SecureRandom.urlsafe_base64
    user.name = "guestuser"
    end
  end

  def active_for_authentication?
    super && is_active
  end

  def inactive_message
    is_active ? super : :inactive
  end

  def guest_user?
    email == 'guest@example.com'
  end

  def total_good_likes
    Comment.joins(:likes)
           .where(user_id: self.id, likes: { likeable_type: 'Comment', reaction_type: Like.reaction_types[:good] })
           .count
  
  end

end
