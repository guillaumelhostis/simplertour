class ConcertsController < ApplicationController

  def new
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build
  end

  def show
    @concert = Concert.find(params[:tour_id])
    @tour = Tour.find(params[:id])
    authorize @concert
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build(concert_params)
    authorize @concert

    # @venue = Venue.find(params[:concert][:venue_id])
    @concert.venue = nil
    if @concert.save
      redirect_to tour_path(@tour), notice: 'Concert was successfully created.'
    else
      redirect_to tour_path(@tour), notice: 'Could not add a new show something went wrong'
    end
  end

  def edit
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])
    authorize @concert
  end

  def update
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])
    authorize @concert

    if @concert.update(concert_params)
      redirect_to tour_concert_path(@concert), notice: 'Concert was successfully updated.'
    else
      render :show
    end
  end

  def destroy
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])
    authorize @concert
    @concert.destroy

    redirect_to tour_path(@tour), notice: 'Concert was successfully deleted.'
  end

  def remove_venue

    @concert = Concert.find(params[:tour_id])


    @concert.update(venue_id: nil)

    respond_to do |format|
      format.js
    end
  end

  private

  def concert_params
    params.require(:concert).permit(:date, :location, :name, :venue_id)
  end


end
