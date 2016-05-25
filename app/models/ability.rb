class Ability
    include CanCan::Ability

    def initialize(user)
        if user.has_role? :admin
            can :manage, :all
            
        elsif user.has_role? :courier
            can :read, Product
            can :read, Order
        end
    end
    
end
