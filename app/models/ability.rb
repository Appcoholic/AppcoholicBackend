class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)
        if user.has_role? :admin
            can :manage, :all
            
        elsif user.has_role? :courier
            can :read, Product
            can :read, Order
            can :accept_order, Order
            can :complete_order, Order
            
            # Couriers can view their own profiles
            can :manage, User, :id => user.id
        else
            can :create, Order
            can :track_order, Order
        end
    end
    
end
