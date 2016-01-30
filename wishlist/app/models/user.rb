class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :lists, dependent: :destroy
  has_many :invitations, foreign_key: 'invited_user_id'
  has_many :gifts, foreign_key: 'assigned_user'
  has_many :notifications, dependent: :destroy


  # User::Roles
  # The available roles
  Roles = [ :owner ,:participant , :user ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
