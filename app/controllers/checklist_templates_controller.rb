class ChecklistTemplatesController < ApplicationController

  def new

    @concert = params[:concert]
    @tour = params[:tour]
    @template = ChecklistTemplate.new

    authorize @template

  end

  def create
    @concert = Concert.find(params[:checklist_template][:concert])

    @tour = Tour.find(params[:checklist_template][:tour])


    @template = ChecklistTemplate.new(template_params)
    @template.tourman_id = current_tourman.id
    if @template.save
      authorize @template

      redirect_to tour_concert_path(@concert.id, @tour.id, ), notice: "Template created successfully."

    else
      flash[:alert] = "Error: Template not created"
      render :new, notice: "Something went wrong"
    end
  end

  private

  def template_params
    params.require(:checklist_template).permit(:name)
  end

end
