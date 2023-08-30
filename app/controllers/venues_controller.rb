class VenuesController < ApplicationController

  def new
    @venue = Venue.new
    authorize @venue
  end

  def show
    @venue = Venue.find(params[:id])

    authorize @venue
  end

  def create
    @venue = Venue.new(venue_params)
    authorize @venue
    @venue.tourman_id = current_tourman.id

    # @venue = Venue.find(params[:concert][:venue_id])
    if @venue.save
      redirect_to venue_path(@venue), notice: 'Concert was successfully created.'
    else
      redirect_to new_venue_path, notice: 'Could not add a new show something went wrong'
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    authorize @venue
    @venue.destroy
    redirect_to tours_path, notice: 'Venue was successfully destroyed.'
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :capacity, :postcode, :address, :city, :country, :tourman_id)
  end


end
