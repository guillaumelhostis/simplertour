class NotesController < ApplicationController
  before_action :set_concert_and_tour

  def create
    @note = Note.new(note_params.merge(concert_id: @concert.id))
    authorize @note
    if @note.save
      redirect_to tour_concert_path(@concert, @tour), notice: 'New contact added'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    if @note.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: 'Notes Deleted'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  private

  def note_params
    params.require(:note).permit(:description, :concert_id)
  end

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end
end
