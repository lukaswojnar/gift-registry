class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start
      t.datetime :end 
      t.timestamps null: false
      t.belongs_to :list, index: true
    end
  end
end
