class Notification < ActiveRecord::Base
  belongs_to :user  
  belongs_to :list
  validates_date :date, :after => :now
end
