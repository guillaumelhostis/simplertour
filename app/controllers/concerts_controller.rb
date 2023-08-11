class ConcertsController < ApplicationController

  def new
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build

  end

  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.build(concert_params)
    authorize @concert

    if @concert.save
      redirect_to tour_path(@tour), notice: 'Concert was successfully created.'
    else
      render 'tours/show'
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
      redirect_to tour_path(@tour), notice: 'Concert was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:id])
    authorize @concert
    @concert.destroy

    redirect_to tour_path(@tour), notice: 'Concert was successfully deleted.'
  end

  private

  def concert_params
    params.require(:concert).permit(:date, :location, :name)
  end

end
