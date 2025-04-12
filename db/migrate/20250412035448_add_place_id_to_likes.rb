class AddPlaceIdToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :place, null: false, foreign_key: true
  end
end
