class Order < ActiveRecord::Base
    validates :address, :presence => true
    
    has_many :order_items, dependent: :destroy
    accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
    
    def total
        
    end
end
