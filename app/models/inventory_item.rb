class InventoryItem < ActiveRecord::Base
    belongs_to :product
    belongs_to :inventory_order
    
    validates :quantity, :presence => true
end
