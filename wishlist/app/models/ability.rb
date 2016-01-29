class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    # Define User abilities
    if user.is? :owner
      can :manage, all
    elsif user.is? :participant
      can :read
    else
      can :read
    end


  end
end
