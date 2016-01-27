class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description
      t.datetime :event_date
      t.text :address
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
