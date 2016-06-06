class Location < ActiveRecord::Base
    
    # Associations
    has_many :inventory_orders
    
    has_many :products, through: :inventories
    has_many :inventories
    
    has_many :orders
    
    # Geocoder
    geocoded_by :address
    after_validation :geocode
    
    
    
    def has_enough_stock?(order)
        # Check if there is enough stock for the order, in the location assigned to the order 
        enough_stock = true
        
        # For each order item in the order
        order.order_items.each do |item|
            product = item.product
            quantity = item.quantity
            inventory = Inventory.where(:product_id => product.id, :location_id => self.id).first
            
            # Check that the location actually has this product, and enough quantity
            if (inventory.blank?) || (inventory.stock_quantity < quantity)
                # Not enough inventory in this location for this order
                enough_stock = false
            end
        end
        
        return enough_stock
    end
    
    def decrease_stock(order)
        # Decreases the stock in the location, according to the order received.
        order.order_items.each do |item|
            # Find the product in the inventories table
            inventory = self.inventories.find_by_product_id(item.product.id)
            
            # Decrease the quantity
            inventory.stock_quantity -= item.quantity
            inventory.save
        end
    
    end
end
