class InventoryOrdersController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    
    before_action :find_inventory_order, only: [:show]
    
    def index
       @inventory_orders = InventoryOrder.all.order('created_at DESC') 
    end
    
    def new
        @inventory_order = InventoryOrder.new
    end

    def create
        @inventory_order = InventoryOrder.new(inventory_order_params)
        # location_id = params[:inventory][:location_id]
        
        # # Check if the item already exists in InventoryOrder table
        # product_id = params[:inventory][:product_id]
        
        
        # @inventory_order = InventoryOrder.where(:product_id => product_id, :location_id => location_id).first
        
        # if @inventory_order.blank?
        #     @inventory_order = InventoryOrder.new(inventory_params)
        # else
        #     @inventory_order.quantity += params[:inventory][:quantity].to_i
        # end
       
        respond_to do |format|
            if @inventory_order.save
                format.html { redirect_to @inventory_order, :flash => { :success => 'Inventory order entry created successfully.' } }
            else
                format.html { render 'new', :flash => { :danger => 'Error creating inventory order.' } }
            end 
        end
    end
    
    def show
    end
    
    private
    
        def find_inventory_order
           @inventory_order = InventoryOrder.find(params[:id] )
        end
    
        def inventory_order_params
           params.require(:inventory_order).permit(:location_id, :inventory_items_attributes => [:id, :product_id, :inventory_order_id, :_destroy, :quantity]) 
        end
    
end
