class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :update, :destroy], List, :user_id => user.id
    can [:update, :read], Gift, :list => { :user_id => user.id }
  end
end
