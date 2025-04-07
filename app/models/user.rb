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
  


  
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
    user.password = SecureRandom.urlsafe_base64
    user.name = "guestuser"
    end
  end

  def active_for_authentication?
    super && (self.is_active == true)
  end

  def guest_user?
    email == 'guest@example.com'
  end

  def inactive_message
    !withdrawal ? super : :withdrawn_account
  end
end
