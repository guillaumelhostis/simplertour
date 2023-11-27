class ContactsController < ApplicationController
  def create
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @contact = Contact.new(contact_params)
    @contact.concert_id = @concert.id
    authorize @contact
    if @contact.save
      redirect_to tour_concert_path(@concert, @tour)
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'New contact added'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:role, :full_name, :country_code, :concert_id, :phone_number, :email)
  end
end
