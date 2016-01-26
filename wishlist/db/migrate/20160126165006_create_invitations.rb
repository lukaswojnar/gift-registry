class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.boolean :attend
      t.belongs_to :event, index: true
      t.timestamps null: false
    end
  end
end
