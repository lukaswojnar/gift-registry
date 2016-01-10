class CreateGiftlists < ActiveRecord::Migration
  def change
    create_table :giftlists do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
