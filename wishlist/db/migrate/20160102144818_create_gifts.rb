class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :price
      t.timestamps null: false
      t.belongs_to :list, index: true
      t.belongs_to :assigned_user, class_name: 'User', null: true, index: true
    end
  end
end
