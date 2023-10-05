class ChecklistsController < ApplicationController
  before_action :set_concert
  before_action :set_checklist, only: [:update]

  def create

    @checklist = @concert.checklists.build(checklist_params)
    authorize @checklist
    if @checklist.save
      redirect_to tour_concert_path(@concert, @tour), notice: "Checklist item added."
    else

      redirect_to tour_concert_path(@concert, @tour)
    end
  end


  def update
    respond_to do |format|
      if @checklist.update(checklist_params)
        format.json { render json: @checklist, status: :ok }
      else
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

# app/controllers/checklists_controller.rb
  def import
    @concert = Concert.find(params[:concert_id])
    template_id = params[:template_id]

    if template_id == 'new'
      # Redirect the user to create a new template
      redirect_to new_concert_checklist_template_path(@concert)
    else
      template = ChecklistTemplate.find(template_id)
      # Rest of the import logic as previously described
      # ...
    end
  end


  private

  def set_concert
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
  end

  def checklist_params
    params.require(:checklist).permit(:description, :status)
  end

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end
end
