class AddEventDateToLists < ActiveRecord::Migration
  def change
    add_column :lists, :event_date, :datetime
  end
end
