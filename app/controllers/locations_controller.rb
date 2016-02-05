class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 10, :order => 'distance')
      if @locations == []
        flash[:notice] = "No Users Found!"
      else
        @hash = Gmaps4rails.build_markers (@locations) do |location, marker|
          marker.lat location.latitude
          marker.lng location.longitude
           location.users.each do |x|
             marker.infowindow x.name
           end
        end
      end
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = set_location
      @hash = Gmaps4rails.build_markers (@location) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
         location.users.each do |x|
           marker.infowindow x.name
         end
      end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = set_location

  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        @location.users << current_user
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def set_user
      @user = User.find(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :latitude, :longitude)
    end
end
