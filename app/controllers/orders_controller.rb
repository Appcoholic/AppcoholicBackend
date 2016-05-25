class OrdersController < ApplicationController
    
    layout "home/home", only: [:new, :track_order, :order_status]
    
    before_action :authenticate_user!, except: [:track_order, :order_status]
    load_and_authorize_resource except: [:track_order, :order_status]
    
    before_action :find_order, only: [:show, :edit, :update, :destroy, :assign_courier]
    
    def index
        @orders = Order.all
    end
    
    def new
        @order = Order.new
    end
    
    def create
        @order = Order.new(order_params)
        
        # Generate a unique token for this order
        @order.token = SecureRandom.urlsafe_base64(16)
        
        respond_to do |format|
            if @order.save
                format.html { redirect_to order_complete_path, :flash => { :success => 'Order has been placed successfully.' } }
                format.json { render :show, status: :created, location: @order }
            else
                format.html { render :new, :flash => { :danger => 'There was an error trying to place your order. Please try again.' } }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def show
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
    end
    
    def assign_courier
        @courier = User.find(params[:courier_id])
        
        @order.courier = @courier
        
        respond_to do |format|
            if @order.save
                format.html { redirect_to @order, :flash => { :success => 'Courier successfully assigned to order.' } }
                format.json { render :show, status: :assigned, location: @order }
            else
                format.html { render :new, :flash => { :danger => 'There was an error trying to assign the courier to this order. Please try again.' } }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        
        def find_order
            @order = Order.find(params[:id])
        end
        
        def order_params
           params.require(:order).permit(:address, :comments, :order_items_attributes => [:id, :product_id, :order_id, :_destroy, :quantity]) 
        end
end
