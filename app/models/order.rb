class Order < ActiveRecord::Base
    include ActiveModel::Dirty
    
    # Status Enums
    enum status: [:pending, :delivering, :completed, :cancelled]
    
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
    before_save :generate_token
    after_save :decrease_stock, :if => :is_completed?
    
    private
    
        def generate_token
            # Generate a unique token for this order
            self.token = SecureRandom.urlsafe_base64(16)
        end
    
        def is_completed?
           self.completed?
        end
    
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
            location = Location.find(self.location_id)
            
            # For each order item in the order
            self.order_items.each do |item|
                product = item.product
                quantity = item.quantity
                inventory = Inventory.where(:product_id => product.id, :location_id => location.id).first
                
                # Check that the location actually has this product, and enough quantity
                if (inventory.blank?) || (inventory.stock_quantity < quantity)
                    # Not enough inventory in this location for this order
                    errors.add(:location_id, "#{location.address} Does not have enough stock for #{product.name}.")
                end
            end
        end
        
        def decrease_stock
            # Decreases the product's stock quantity in the order's location when the order is marked as completed.
            location = self.location
           
            self.order_items.each do |item|
                # Find the product in the inventories table
                inventory = location.inventories.find_by_product_id(item.product.id)
                
                # Decrease the quantity
                inventory.stock_quantity -= item.quantity
                inventory.save
            end
        end
        
end