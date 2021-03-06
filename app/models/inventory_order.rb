class InventoryOrder < ActiveRecord::Base
    
    # Associations
    belongs_to :location
    has_many :inventory_items, dependent: :destroy
    accepts_nested_attributes_for :inventory_items, reject_if: :all_blank, allow_destroy: true
    
    # ActiveRecord Callbacks
    before_save :generate_token
    after_save :update_stock
    
    
    
    private
    
        def generate_token
            # Generate a unique token for this inventory order
            self.token = SecureRandom.urlsafe_base64(16)
        end
    
        def update_stock
            # Update the Inventory table stock
            self.inventory_items.each do |item|
                
                # Check if the product already exists in the table for this order's location
                # If it does not exist, create it with the specified quantity.
                inventory = Inventory.find_or_initialize_by(product_id: item.product.id, location_id: self.location.id)
                inventory.stock_quantity.blank? ? inventory.stock_quantity = item.quantity : inventory.stock_quantity += item.quantity
                inventory.save
            end
        end
end
