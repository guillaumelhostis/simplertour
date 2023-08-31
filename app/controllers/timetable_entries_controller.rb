class TimetableEntriesController < ApplicationController

  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @timeentry = TimetableEntry.new(timetable_entries_params)

    @timeentry.concert_id = @concert.id
    authorize @timeentry
    respond_to do |format|
      if @timeentry.save
        # format.html { redirect_to @concert, notice: 'Timetable entry was successfully created.' }
        format.js   # This line will look for create.js.erb in the views/timetable_entries folder
      else
        format.html { render 'concerts/show' }
        format.js { render 'error' } # You can create an error.js.erb file for error handling
      end
    end


  end

  def destroy

  end

  private

  def timetable_entries_params
    params.require(:timetable_entry).permit(:hourminute, :information, :concert_id)
  end
end
