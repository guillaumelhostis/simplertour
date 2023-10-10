
class TransportUsersController < ApplicationController
  def create
    @transport = Transport.find(params[:transport_id])
    @user = User.find(params[:transport_user][:user_id])
    @transport_user = TransportUser.new(transport: @transport, user: @user)
    @concert = Concert.find(params[:concert_id])
    @tour = Tour.find(params[:tour_id])
    authorize @transport_user
    if @transport_user.save
      redirect_to tour_concert_path(@concert, @tour), notice: 'User added'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def update
    @concert = Concert.find(params[:concert_id])
    @tour = Tour.find(params[:tour_id])
    @transport_user = TransportUser.find(params[:id])
    authorize @transport_user
    if @transport_user.update(transport_user_params)
      redirect_to tour_concert_path(@concert, @tour), notice: 'Attachment added'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy
    @tour = Tour.find(params[:tour_id])
    @concert = @tour.concerts.find(params[:concert_id])
    @transport_user = TransportUser.find(params[:id])
    @transport_user.destroy
    authorize @transport_user
    redirect_to tour_concert_path(@concert, @tour), notice: 'User Delete'
  end

  def destroy_attachment
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
    @transport_user = TransportUser.find(params[:id])
    @image = ActiveStorage::Attachment.find(params[:attachment_id])
    authorize @transport_user
    @image.purge
    redirect_to tour_concert_path(@concert, @tour), notice: 'Attachment deleted'
  end

  private

  def transport_user_params
    params.require(:transport_user).permit(files: [])
  end

end
