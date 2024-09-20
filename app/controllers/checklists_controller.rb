class ChecklistsController < ApplicationController
  before_action :set_concert_and_tour
  before_action :set_checklist, only: [:update, :destroy]

  def create
    @checklist = @concert.checklists.build(checklist_params)
    authorize @checklist
    if @checklist.save
      redirect_to tour_concert_path(@concert, @tour), notice: "Checklist item added."
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Something went wrong"
    end
  end

  def update
    authorize @checklist
    @checklist.update(checklist_params)
    head :no_content
  end

  def destroy
    authorize @checklist
    if @checklist.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: 'Checkbox Deleted'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def import
    service = ChecklistImportService.new(params[:format].to_i, @concert)
    service.call
    if service.success
      authorize service.checklist
      redirect_to tour_concert_path(@concert, @tour), notice: "Checklist template added."
    else
      redirect_to tour_concert_path(@concert, @tour), notice: "Couldn't import checklists"
    end
  end

  private

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end

  def checklist_params
    params.require(:checklist).permit(:description, :status)
  end

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end
end
