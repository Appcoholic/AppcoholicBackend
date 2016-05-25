class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)
        if user.has_role? :admin
            can :manage, :all
            
        elsif user.has_role? :courier
            can :read, Product
            can :read, Order
        else
            can :create, Order
            can :track, Order
        end
    end
    
end
