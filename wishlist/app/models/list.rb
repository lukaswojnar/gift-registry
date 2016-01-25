class List < ActiveRecord::Base
  has_many :gifts
  belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
end
