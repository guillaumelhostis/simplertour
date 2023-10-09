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
    if @venue.save
      params[:venue][:files].each do |file|
        @venue.files.attach(file)
      end
      redirect_to venue_path(@venue), notice: 'Concert was successfully created.'
    else
      redirect_to new_venue_path, notice: 'Could not add a new show something went wrong'
    end
  end

  def edit
    @venue = Venue.find(params[:id])
    @existing_files = @venue.files
    authorize @venue
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update(venue_params)
      authorize @venue
      redirect_to venue_path(@venue)
    else
      redirect_to edit_venue_path(@venue), notice: 'Something went wrong'
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
    params.require(:venue).permit(:name, :capacity, :postcode, :address, :city, :country, :tourman_id, files: [])
  end
end
