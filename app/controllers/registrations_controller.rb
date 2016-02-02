class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :gender, :birthday, :species, :email, :password, :password_confirmation, :avatar, :address, :latitude, :longitude)}
  end

  def account_update_params
    params.require(:user).permit(:name, :gender, :birthday, :species, :email, :password, :password_confirmation, :current_password, :avatar, :address, :latitude, :longitude)
  end

end
