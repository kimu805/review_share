class RemoveWorkFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_reference :reviews, :work, null: false, foreign_key: true
  end
end
