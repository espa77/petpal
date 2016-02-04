class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]

  def create
    super
    if resource.save
      UserNotifier.send_signup_email(@user).deliver_now
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :gender, :birthday, :species, :email, :password, :password_confirmation, :avatar, :address, :latitude, :longitude)}
  end

  def account_update_params
    params.require(:user).permit(:name, :gender, :birthday, :species, :email, :password, :password_confirmation, :current_password, :avatar, :address, :latitude, :longitude)
  end

end
