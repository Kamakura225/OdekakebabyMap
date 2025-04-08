class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :rating
      t.references :user, foreign_key: true, null: false
      t.references :place, foreign_key: true, null: false
      t.timestamps
    end
  end
end
