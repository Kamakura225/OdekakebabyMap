class CreatePlaceFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :place_features do |t|
      t.references :place, foreign_key: true, null: false
      t.references :feature, foreign_key: true, null: false
      t.timestamps
    end
  end
end
