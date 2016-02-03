class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :role
      t.references :user, index: true, foreign_key: true
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
