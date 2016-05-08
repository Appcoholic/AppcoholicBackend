class UsersController < ApplicationController
    
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :find_user, only: [:show, :edit, :update, :destroy]
    
    def index
        @users = User.all
    end
    
    def new
       @user = User.new 
    end
    
    def create
        @user = User.new(user_params)
        
        respond_to do |format|
            if @user.save
                format.html { redirect_to users_path, :flash => { :success => 'User added successfully.' } }
            else
                format.html { render 'new', :flash => { :danger => 'Error adding user.' } }
            end
        end
    end
    
    def edit
    end
    
    def update
        
        # Remove the password key of the params hash if it’s blank. If not, Devise will fail to validate
        if params[:user][:password].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
        end
        
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to users_path, notice: 'User was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end
    
    def destroy
       @user.destroy
        respond_to do |format|
            format.html { redirect_to users_path, notice: 'User was successfully deleted.' }
        end 
    end
    
    private
        
        def find_user
            @user = User.find(params[:id])
        end
        
        def user_params
           params.require(:user).permit(:email, :password, :password_confirmation, {role_ids: []}) 
        end
end
