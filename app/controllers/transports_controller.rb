class TransportsController < ApplicationController
  before_action :set_concert_and_tour, only: [:create, :update, :destroy]
  before_action :set_transport, only: [:update, :destroy]

  def create
    service = TransportCreationService.new(transport_params, @concert)
    service.call
    authorize service.transport
    if service.success
      redirect_to tour_concert_path(@concert, @tour), notice: 'Transport created'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def update
    if @transport.update(transport_params)
      redirect_to tour_concert_path(@concert, @tour), notice: 'Notes Updated'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy
    if @transport.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: 'Transport deleted'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  private

  def transport_params
    params.require(:transport).permit(:time_of_depart, :time_of_arrival, :notes, :way_of_transport, :concert_id, :place_of_arrival, :place_of_depart)
  end

  def set_concert_and_tour
    @concert = Concert.find(params[:concert_id])
    @tour = Tour.find(@concert.tour_id)
  end

  def set_transport
    @transport = Transport.find(params[:id])
    authorize @transport
  end
end
