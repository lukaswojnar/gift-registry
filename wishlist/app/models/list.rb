class List < ActiveRecord::Base
  belongs_to :user
  has_many :gifts
  has_many :invitations
end
