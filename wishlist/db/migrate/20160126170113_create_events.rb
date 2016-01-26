class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.text :address
      t.belongs_to :list, index: true
      t.timestamps null: false
    end
  end
end
