class TimetableEntriesController < ApplicationController

  def create

    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @timeentry = TimetableEntry.new(timetable_entries_params)


    @timeentry.concert_id = @concert.id
    authorize @timeentry

    if @timeentry.save
      redirect_to tour_concert_path(@concert, @tour)
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'You have to insert en event'
    end
  end


  private

  def timetable_entries_params
    params.require(:timetable_entry).permit(:hourminute, :hourminuteend, :information, :concert_id)
  end
end
