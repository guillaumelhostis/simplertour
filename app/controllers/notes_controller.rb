class NotesController < ApplicationController
  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @note = Note.new(note_params)


    @note.concert_id = @concert.id
    authorize @note

    if @note.save
      redirect_to tour_concert_path(@concert, @tour)
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'New contact added'
    end
  end



  private

  def note_params
    params.require(:note).permit(:description, :concert_id)
  end
end
