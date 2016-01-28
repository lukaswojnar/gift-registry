class AddAddressToLists < ActiveRecord::Migration
  def change
    add_column :lists, :address, :string
  end
end
