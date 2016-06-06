class OrdersController < ApplicationController
    
    layout "home/home", only: [:new, :create, :track_order, :order_status]
    
    before_action :authenticate_user!, except: [:new, :create, :track_order, :order_status]
    load_and_authorize_resource except: [:new, :track_order, :order_status]
    
    before_action :find_order, except: [:index, :new, :create, :track_order, :order_status]
    
    def index
        @orders = Order.all.order("created_at DESC")
    end
    
    def new
        @order = Order.new
    end
    
    def create
        @order = Order.new(order_params)
        
        respond_to do |format|
            if @order.save
                format.html { redirect_to order_status_path(:token => @order.token), :flash => { :success => 'Order has been placed successfully.' } }
            else
                format.html { render :new, :flash => { :danger => 'There was an error trying to place your order. Please try again.' } }
            end
        end
    end
    
    def show
        @marker = find_marker
    end
    
    def destroy
        @order.destroy
        respond_to do |format|
            format.html { redirect_to orders_path, notice: 'Order was successfully deleted.' }
        end 
    end
    
    def track_order
    end
    
    def order_status
        @token = params[:token]
        
        @order = Order.find_by_token(@token)
        @marker = find_marker
    end
    
    def assign_courier
        # First, find the nearest stock location, if there is one available
        @order.location = Order.get_nearest_stock_location(@order)
        
        # Find the courier user
        @courier = User.find(params[:courier_id])
        
        # Assign the courier
        @order.courier = @courier
        
        # Change the status
        @order.status = :delivering
        
        respond_to do |format|
            if @order.save
                flash[:success] = 'Courier and stock location successfully assigned to order.'
                format.js
            else
                format.js
            end
        end
    end
    
    def accept_order
        # First, find the nearest stock location, if there is one available
        @order.location = Order.get_nearest_stock_location(@order)
        
        # Get the courier user
        @courier = current_user
        
        # Set the courier to the order
        @order.courier = @courier
        
        # Change the order's status to delivering
        @order.status = :delivering
        
        # Save the order
        respond_to do |format|
            if @order.save
                flash[:success] = 'The order has been successully assigned to you. Please deliver it as soon as possible.'
                format.js
            else
                format.js
            end
        end
    end
    
    def cancel_order
        # Change the order's status to delivering
        @order.status = :cancelled
        
        # Save the order
        respond_to do |format|
            if @order.save
                format.html { redirect_to @order, :flash => { :success => 'The order has been cancelled.' } }
                format.json { render :show, status: :canceled, location: @order }
            else
                format.html { render :new, :flash => { :danger => 'There was an error trying to cancel this order. Please try again.' } }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def complete_order
        # Change the order's status to delivering
        @order.status = :completed
        
        # Save the order
        respond_to do |format|
            if @order.save
                format.html { redirect_to @order, :flash => { :success => 'The order has been marked as completed.' } }
                format.json { render :show, status: :completed, location: @order }
            else
                format.html { render :new, :flash => { :danger => 'There was an error trying to mark this order as completed. Please try again.' } }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
    
        def find_marker
            # Order address location's map marker
            @marker = Gmaps4rails.build_markers(@order) do |order, marker|
                marker.lat order.latitude
                marker.lng order.longitude
            end
            @marker
        end
        
        def find_order
            @order = Order.find(params[:id])
        end
        
        def order_params
           params.require(:order).permit(:address, :comments, :order_items_attributes => [:id, :product_id, :order_id, :_destroy, :quantity]) 
        end
end
