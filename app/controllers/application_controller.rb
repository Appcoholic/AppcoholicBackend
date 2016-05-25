class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
  
    # If CanCan privileges are denied
    rescue_from CanCan::AccessDenied do |e|
        flash[:danger] = "You do not have permission to perform this action."
        redirect_to dashboard_path
    end
  
    def after_sign_in_path_for(resource)
        dashboard_path
    end
end
