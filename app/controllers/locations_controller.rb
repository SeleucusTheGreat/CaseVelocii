class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations or /locations.json
  def index
    if params[:place].present?
      begin
        @locations = Location.near(params[:place], params[:radius], order: :distance)
      rescue Geocoder::Error => e
        Rails.logger.error("Geocoding error: #{e.message}")
        flash[:alert] = "There was a problem with the geocoding service. Please try again later."
        @locations = Location.all
      end
    else
      @locations = Location.all
    end
  end

  # GET /locations/1 or /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    if valid_address?(@location.address)
      if @location.save
        redirect_to @location, notice: 'Location was successfully created.'
      else
        render :new
      end
    else
      flash[:alert] = 'The address is not valid. Please enter a valid address.'
      render :new
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
        if valid_address?(@location.address)
          if @location.update(location_params)
            redirect_to @location, notice: 'Location was successfully created.'
          else
            render :edit
          end
        else
          flash[:alert] = 'The address is not valid. Please enter a valid address.'
          render :edit
        end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:name, :address, :latitude, :longitude)
    end

    def valid_address?(address)
      geocoded_data = Geocoder.search(address)
      geocoded_data.present? && geocoded_data.first&.coordinates.present?
    end
end
