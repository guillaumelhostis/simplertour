class ContactsController < ApplicationController
  before_action :set_concert_and_tour, only: [:create]

  def create
    @contact = Contact.new(contact_params.merge(concert_id: @concert.id))
    authorize @contact
    if @contact.save
      redirect_to tour_concert_path(@concert, @tour), notice: "Contact added."
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:role, :full_name, :country_code, :concert_id, :phone_number, :email)
  end

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end
end
