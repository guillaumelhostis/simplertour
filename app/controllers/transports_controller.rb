class TransportsController < ApplicationController
  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @transport = Transport.new(transport_params)

    concert_date = @concert.date
    arrival_hour = @transport.time_of_arrival.hour
    arrival_minute = @transport.time_of_arrival.min
    depart_hour = @transport.time_of_depart.hour
    depart_minute = @transport.time_of_depart.min
    new_time_of_arrival = Time.new(concert_date.year, concert_date.month, concert_date.day, arrival_hour, arrival_minute)
    new_time_of_depart = Time.new(concert_date.year, concert_date.month, concert_date.day, depart_hour, depart_minute)
    @transport.time_of_arrival = new_time_of_arrival
    @transport.time_of_depart = new_time_of_depart
    @transport.concert_id = @concert.id

    authorize @transport

    if @transport.save
      redirect_to tour_concert_path(@concert, @tour)
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'New contact added'
    end
  end

  def update

    @transport = Transport.find(params[:id])
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])


    authorize @transport
    if @transport.update(transport_params)
      redirect_to tour_concert_path(@concert, @tour), notice: 'Notes Updated'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end



  private

  def transport_params
    params.require(:transport).permit(:time_of_depart, :time_of_arrival, :notes, :way_of_transport, :concert_id, :place_of_arrival, :place_of_depart)
  end
end
