class Invitation < ActiveRecord::Base
  belongs_to :user, foreign_key: 'invited_user'
end
