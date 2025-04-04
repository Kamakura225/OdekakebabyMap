class AddLatitudeAndLongitudeToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :latitude, :float unless column_exists?(:places, :latitude)
    add_column :places, :longitude, :float unless column_exists?(:places, :longitude)
  end
end
