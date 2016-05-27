class Order < ActiveRecord::Base
    include ActiveModel::Dirty
    
    # Status Enums
    enum status: [:Pending, :Delivering, :Completed, :Cancelled]
    
    # Validations
    validates :address, :presence => true
    validate :check_stock, :on => :update, :if => :location_id_changed?
    
    # Associations
    belongs_to :courier, :class_name => 'User', :foreign_key => 'courier_id'
    belongs_to :location
    
    has_many :order_items, :dependent => :destroy
    accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
    
    # ActiveRecord Callbacks
    before_save :calculate_total
    
    
    private
    
        def calculate_total
            self.order_total = 0
            
            self.order_items.each do |item|
                unless item.marked_for_destruction?
                    self.order_total += (item.quantity * item.product.unit_price)
                end
            end
        end
        
        def check_stock
            # Check if there is enough stock for the order, in the location assigned to the order 
            location_id = self.location_id
            
            # For each order item in the order
            self.order_items.each do |item|
                product = item.product
                quantity = item.quantity
                inventory = Inventory.where(:product_id => product.id, :location_id => location_id).first
                
                # Check that the location actually has this product, and enough quantity
                if (inventory.blank?) || (inventory.quantity < quantity)
                    # Not enough inventory in this location for this order
                    errors.add(:location_id, "Does not have enough stock for this order.")
                end
            end
        end
        
end