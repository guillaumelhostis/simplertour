class TimetableEntriesController < ApplicationController

  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @timeentry = TimetableEntry.new(timetable_entries_params)

    @timeentry.concert_id = @concert.id
    authorize @timeentry

    @timeentry.save
    redirect_to tour_concert_path(@concert, @tour)
  end

  def destroy

  end

  private

  def timetable_entries_params
    params.require(:timetable_entry).permit(:hourminute, :hourminuteend, :information, :concert_id)
  end
end
