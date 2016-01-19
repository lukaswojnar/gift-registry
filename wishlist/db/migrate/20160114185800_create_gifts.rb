class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.text :description
      t.float :price
      t.string :link
      t.integer :status

      t.timestamps null: false
    end
  end
end
