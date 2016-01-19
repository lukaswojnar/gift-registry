class AddGiftlistToGifts < ActiveRecord::Migration
  def change
    add_reference :gifts, :giftlist, index: true, foreign_key: true
  end
end
