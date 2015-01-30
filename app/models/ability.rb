class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #

      user ||= User.new # guest user (not logged in)
      if user.is_customer?
        can :read, Customer
        can :update, Customer, :user_id => user.id
        can :destroy, Customer, :user_id => user.id
        can :create, Customer, :user_id => nil
        can :read, Provider
        can :search, Provider
      elsif user.is_provider?
        can :read, Provider
        can :update, Provider, :user_id => user.id
        can :destroy, Provider, :user_id => user.id
        can :create, Provider, :user_id => nil
        can :read, Customer
        can :search, Provider
        can :search, Customer
        # cannot [:edit, :create, :destroy], Customer
      else
        can :create, User
        cannot :manage, Customer
        can :read, Provider
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
