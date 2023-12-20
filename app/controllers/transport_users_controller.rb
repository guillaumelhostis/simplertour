class TransportUsersController < ApplicationController
  before_action :set_concert_and_tour, only: [:create, :udpate, :destroy, :destroy_attachment]
  before_action :set_transport_user, only: [:update, :destroy, :destroy_attachment]

  def create
    @transport = Transport.find(params[:transport_id])
    @user = User.find(params[:transport_user][:user_id])
    @transport_user = TransportUser.new(transport: @transport, user: @user)
    authorize @transport_user
    if @transport_user.save
      redirect_to tour_concert_path(@concert, @tour), notice: 'Team member added'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def update
    if @transport_user.update(transport_user_params)
      redirect_to tour_concert_path(@concert, @tour), notice: 'Attachment added'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy
    if @transport_user.destroy
      redirect_to tour_concert_path(@concert, @tour), notice: 'User Delete'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  def destroy_attachment
    @attachment = ActiveStorage::Attachment.find(params[:attachment_id])
    if @attachment.purge
      redirect_to tour_concert_path(@concert, @tour), notice: 'Attachment deleted'
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end

  private

  def transport_user_params
    params.require(:transport_user).permit(files: [])
  end

  def set_concert_and_tour
    @tour = Tour.find(params[:tour_id])
    @concert = Concert.find(params[:concert_id])
  end

  def set_transport_user
    @transport_user = TransportUser.find_by(id: params[:id])
    if @transport_user.present?
      authorize @transport_user
    else
      redirect_to tour_concert_path(@concert, @tour), notice: 'Something went wrong'
    end
  end
end
