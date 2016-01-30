class List < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 500,
                                              too_long: "%{count} characters is the maximum allowed" }
  validates :description, presence:  true, length: { minimum: 3, too_short: " must have at least 3 characters"}

  belongs_to :user
  has_many :gifts, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
