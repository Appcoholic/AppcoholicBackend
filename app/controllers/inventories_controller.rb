class InventoriesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    
    def new
        @inventory = Inventory.new
    end
    
    def create
        # Check if the item already exists in Inventory table
        product_id = params[:inventory][:product_id]
        location_id = params[:inventory][:location_id]
        
        @inventory = Inventory.where(:product_id => product_id, :location_id => location_id).first
        
        if @inventory.blank?
            @inventory = Inventory.new(inventory_params)
        else
            @inventory.quantity += params[:inventory][:quantity].to_i
        end
       
        respond_to do |format|
            if @inventory.save
                format.html { redirect_to @inventory.location, :flash => { :success => 'Inventory entry created successfully.' } }
            else
                format.html { render 'new', :flash => { :danger => 'Error creating inventory entry.' } }
            end 
        end
        
        
    end
    
    private
    
        def inventory_params
           params.require(:inventory).permit(:product_id, :location_id, :quantity) 
        end
    
end
