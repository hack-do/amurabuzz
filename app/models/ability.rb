class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "superadmin"
      can :manage, :all
    elsif user.role == "admin"
      can :manage, User
    elsif user.role == "individual"
      can :read, User
      can :profile, User
      can :friends, User

      can :read, Tweet
      can :create, Tweet

      can :manage, Relationship

      can :manage, Tweet do |child|
        child.user_id == user.id
      end

      # cannot :share, Tweet do |child|
      #   child.user_id == user.id
      # end
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
