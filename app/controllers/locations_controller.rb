class LocationsController < ApplicationController
  
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :find_location, only: [:show, :edit, :update, :destroy]
  
  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end
  
  def create
    @location = Location.new(location_params)
    
    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, :flash => { :success => 'Location created successfully.' } }
      else
        format.html { render 'new', :flash => { :danger => 'Error creating location.' } }
      end
    end
  end

  def show
    # Location's map marker
    @marker = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
    end
    
    @products = Product.all
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @location.update(location_params)
          format.html { redirect_to locations_path, notice: 'Location was successfully updated.' }
      else
          format.html { render :edit }
      end
    end
  end
  
  def destroy
    @location.destroy
    respond_to do |format|
        format.html { redirect_to locations_path, notice: 'Location was successfully deleted.' }
    end 
  end
  
  private
  
    def find_location
      @location = Location.find(params[:id])
    end
    
    def location_params
      params.require(:location).permit(:location_id, :address, :longitude, :latitude)
    end
end
