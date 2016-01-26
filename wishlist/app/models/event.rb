class Event < ActiveRecord::Base
  belongs_to :list
  has_many :invitations
end
