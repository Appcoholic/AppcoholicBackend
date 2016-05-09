class Inventory < ActiveRecord::Base
    
    #validates :product_id, :uniqueness => true
    validates :quantity, :presence => true
    
    belongs_to :product
    belongs_to :location
end
