class AddGeocodingColumnToPlace < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :address, :string, null: false, default: ""
    add_column :places, :latitude, :float, null: false, default: 0
    add_column :places, :longitude, :float, null: false, default: 0
  end
end
