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
            
            # Couriers can complete orders assigned to them
            can :complete_order, Order, :courier_id => user.id
            
            # Couriers can view their own profiles
            can :show, User, :id => user.id
        else
            can :create, Order
            can :track_order, Order
        end
    end
    
end
