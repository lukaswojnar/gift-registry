class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description
      t.string :share_code

      t.timestamps null: false
    end
  end
end
