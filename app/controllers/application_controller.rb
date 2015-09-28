class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin_user!
    authenticate_user! 
    unless current_user.admin?
      redirect_to root_path, notice: t('web.alerts.administrators_only')  
    end
  end
 
  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

  protected

  def configure_permitted_parameters
    if controller_name == 'registrations'
      if action_name == 'create'
        registration_params = [
          :first_name, :last_name, :email, :password, 
          :password_confirmation
        ]
        devise_parameter_sanitizer.for(:sign_up) { 
          |u| u.permit(registration_params)
        }
      elsif action_name == 'update'
        update_params = [
          :first_name, :last_name, :email, :password,
          :password_confirmation, :current_password
        ]
        devise_parameter_sanitizer.for(:account_update) { 
          |u| u.permit(update_params)
        }
      end  
    end  
  end 
end
