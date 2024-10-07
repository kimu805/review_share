class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :title
      t.integer :type
      t.integer :api_id
      t.string :genre
      t.text :description
      t.date :release_date
      t.string :author_or_director
      t.string :thumbnail_url
      t.timestamps
    end
  end
end
