class RemovePlaceIdFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :place_id, :integer
  end
end
