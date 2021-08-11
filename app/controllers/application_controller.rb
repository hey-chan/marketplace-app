class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) {|user| user.permit(:username, :email, :password, :password_confirmation, :street_name, :suburb, :postcode, :state, :country)}
      devise_parameter_sanitizer.permit(:account_update) {|user| user.permit(:name, :email, :password, :current_password)}
    end
end
