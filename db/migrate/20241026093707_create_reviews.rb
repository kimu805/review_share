class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.text :comment
      t.boolean :spoiler

      t.timestamps
    end
  end
end
