class Notification < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :list, dependent: :destroy
end
