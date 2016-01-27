class Invitation < ActiveRecord::Base
  belongs_to :user, foreign_key: 'invited_user_id'
  belongs_to :list
end
