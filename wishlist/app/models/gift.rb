class Gift < ActiveRecord::Base

  validates :title, presence: true, length: { minimum: 2, maximum: 300 }
  validates :description, presence: true, length: { minimum: 5, maximum: 300 }
  # price should be optional?
  validates :link, presence:  true
  # img optional?
  # status?


end
