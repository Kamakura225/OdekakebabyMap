class AddCommentRefToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :comment, foreign_key: true
  end
end
