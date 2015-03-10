class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      if user.is_customer?
        can :read, Customer
        can :update, Customer, :user_id => user.id
        can :destroy, Customer, :user_id => user.id
        can :recover, Customer, :user_id => user.id
        can :create, Customer, :user_id => nil
        can :read, Provider
        can :search, Provider
        can :create, Interest
      elsif user.is_provider?
        can [:read, :search], Provider
        can [:update, :destroy, :recover], Provider, :user_id => user.id
        can :create, Provider, :user_id => nil
        can [:read, :search], Customer
      else
        can :create, User
        cannot :manage, Customer
        can [:read, :carousel], Provider
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
