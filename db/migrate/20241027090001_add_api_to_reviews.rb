class AddApiToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :api, null: false
  end
end
