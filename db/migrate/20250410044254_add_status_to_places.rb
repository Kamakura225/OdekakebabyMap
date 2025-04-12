class AddStatusToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :status, :integer
  end
end
