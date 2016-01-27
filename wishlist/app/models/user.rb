class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :lists, dependent: :destroy
  has_many :invitations, foreign_key: 'invited_user'
  has_many :gifts, foreign_key: 'assigned_user'
end
