class Order < ActiveRecord::Base
    enum status: [:Pending, :Delivering, :Completed, :Cancelled]
    
    validates :address, :presence => true
    
    belongs_to :courier, :class_name => 'User', :foreign_key => 'courier_id'

    has_many :order_items, :dependent => :destroy
    accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
    
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
end
