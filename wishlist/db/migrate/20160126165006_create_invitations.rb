class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.boolean :status
      t.timestamps null: false
      t.belongs_to :invited_user, class_name: 'User', null: true, index: true
      t.belongs_to :list, index: true
    end
  end
end
