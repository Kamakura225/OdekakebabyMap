class ChangeRatingToFloatInComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :rating, :float
  end
end
