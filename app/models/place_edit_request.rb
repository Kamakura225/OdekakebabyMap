class PlaceEditRequest < ApplicationRecord
  belongs_to :user
  belongs_to :place

  has_many_attached :photos

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :name, :address, presence: true
  
  def update_place
    return unless approved?  
    place.update(
      name: name,
      address: address,
      nursery: nursery,
      diaper: diaper,
      kids_toilet: kids_toilet,
      stroller: stroller,
      playground: playground,
      shade: shade,
      bench: bench,
      elevator: elevator,
      parking: parking
    )
    if photos.attached?      
      photos.each do |photo|
        place.photos.attach(photo.blob) # リクエスト側の写真をPlaceにコピー
      end
    end
  end
end
