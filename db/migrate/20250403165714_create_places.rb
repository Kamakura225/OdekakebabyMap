class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.integer :category, null: false, default: 0 # 施設か公園か
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
