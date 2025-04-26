class CreatePlaceEditRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :place_edit_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      
      t.string :name
      t.string :address
      t.boolean :nursery
      t.boolean :diaper
      t.boolean :kids_toilet
      t.boolean :stroller
      t.boolean :playground
      t.boolean :shade
      t.boolean :bench
      t.boolean :elevator
      t.boolean :parking
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
