class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|

      t.timestamps
    end
  end
end
