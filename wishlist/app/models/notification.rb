class Notification < ActiveRecord::Base
  belongs_to :user  
  belongs_to :list

  validate :date_is_valid_datetime

  def date_is_valid_datetime
    # errors.add(:date, 'must be a valid datetime') if ((DateTime.parse(happened_at) rescue ArgumentError) == ArgumentError)
  end
end
