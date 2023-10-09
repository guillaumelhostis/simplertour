
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
end
