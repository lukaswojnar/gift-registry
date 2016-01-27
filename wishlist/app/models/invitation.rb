class Invitation < ActiveRecord::Base
  belongs_to :user, foreign_key: 'invited_user_id'
  belongs_to :list
  validates_uniqueness_of :invited_user_id, :scope => :list_id
end
