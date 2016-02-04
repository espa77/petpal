class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = set_user
    @hash = Gmaps4rails.build_markers (@user.locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
       location.users.each do |x|
         marker.infowindow x.name
       end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :species, :email, :password, :password_confirmation, :avatar, :address, :latitude, :longitude)
  end
end
