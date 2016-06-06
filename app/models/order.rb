class Order < ActiveRecord::Base
    include ActiveModel::Dirty
    
    # Status Enums
    enum status: [:pending, :delivering, :completed, :cancelled]
    
    # Associations
    belongs_to :courier, :class_name => 'User', :foreign_key => 'courier_id'
    belongs_to :location
    
    has_many :order_items, :dependent => :destroy
    accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
    
    # Validations
    validates :address, :presence => true
    validate :valid_location, on: :update, :if => :courier_id_changed?
    
    # ActiveRecord Callbacks
    before_create :calculate_total
    before_create :generate_token
    
    after_save :decrease_stock, :if => :is_completed?
    
    # Geocoder
    geocoded_by :address
    after_validation :geocode          # auto-fetch coordinates
    
    def self.get_nearest_stock_location(order)
        nearest_locations = Location.near([order.latitude, order.longitude], 20, :units => :km).to_a
        
        nearest_locations.each do |location|
            # Return first location that has enough stock
            if location.has_enough_stock?(order)
                return location
            end
        end
        
        return nil
    end
    
    private
    
        def valid_location
           # Validates if a valid location was set when order and courier are assigned
           errors[:base] << "No valid stock location could be found. Insufficient stock on all locations." if self.location.blank?
           return false
        end

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
        
        def decrease_stock
            # Decreases the product's stock quantity in the order's location when the order is marked as completed.
            location = self.location
           
            location.decrease_stock(self)
        end
        
end