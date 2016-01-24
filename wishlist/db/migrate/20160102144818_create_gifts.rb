class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :price
      t.string :assigned_to
      t.timestamps null: false
    end
  end
end
