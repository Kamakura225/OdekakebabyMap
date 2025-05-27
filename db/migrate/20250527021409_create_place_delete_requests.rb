class CreatePlaceDeleteRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :place_delete_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true      
      t.text :reason
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
