class AddListReferencesToGifts < ActiveRecord::Migration
  def change
    add_reference :gifts, :list, index: true, foreign_key: true
  end
end
