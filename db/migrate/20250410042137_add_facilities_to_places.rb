class AddFacilitiesToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :nursery, :boolean
    add_column :places, :diaper, :boolean
    add_column :places, :kids_toilet, :boolean
    add_column :places, :stroller, :boolean
    add_column :places, :playground, :boolean
    add_column :places, :shade, :boolean
    add_column :places, :bench, :boolean
    add_column :places, :elevator, :boolean
    add_column :places, :parking, :boolean
  end
end
