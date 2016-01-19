class Giftlist < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 2, maximum: 300 }
  validates :description, presence: true, length: { minimum: 5, maximum: 300 }

  has_many :gifts
end
