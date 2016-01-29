class ChangeTypeOfRoleToInt < ActiveRecord::Migration
  def self.up
    change_table :permissions do |t|
      t.change :role, :integer
    end
  end
  def self.down
    change_table :permissions do |t|
      t.change :role, :integer
    end
  end
end
