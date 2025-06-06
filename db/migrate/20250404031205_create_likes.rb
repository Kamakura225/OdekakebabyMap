class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :likeable, polymorphic: true, null: false
      t.integer :reaction_type
      t.timestamps
    end
  end
end
