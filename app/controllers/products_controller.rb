class ProductsController < ApplicationController
    
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :find_product, only: [:show, :edit, :update, :destroy]
    
    def index
        @products = Product.all
    end
    
    def show
    end
        
    def new
        @product = Product.new
    end
    
    def create
        @product = Product.new(product_params)
       
        respond_to do |format|
            if @product.save
                format.html { redirect_to products_path, :flash => { :success => 'Product added successfully.' } }
            else
                format.html { render 'new', :flash => { :danger => 'Error adding product.' } }
            end
        end
    end
    
    def edit
    end
    
    def update
        respond_to do |format|
            if @product.update(product_params)
                format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end
    
    def destroy
        @product.destroy
        respond_to do |format|
            format.html { redirect_to products_path, notice: 'Product was successfully deleted.' }
        end 
    end
    
    private
    
        def find_product
            @product = Product.find(params[:id])
        end
        
        def product_params
           params.require(:product).permit(:name, :description, :product_id, :unit_price, :photo) 
        end
end
