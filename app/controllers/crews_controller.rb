class CrewsController < ApplicationController
  before_action :set_crew, only: [:show, :edit, :update, :destroy]


  def index
    @crews = policy_scope(Crew)
  end

  def show
    authorize @crew
    @users = User.all
    @crew_users = @crew.users
    @tour = Tour.find_by(crew_id: @crew.id)
  end


  def assign_users
    @crew = Crew.find(params[:id])
    @users = User.where(id: params[:user_ids])

    if @crew.users.exists?(id: @users.ids[0])
      redirect_to @crew, notice: "User is already in the team #{@crew.name}"
      authorize @crew
    else
      @crew.users << @users
      authorize @crew
      @crew.save
      redirect_to @crew, notice: 'Users were successfully assigned.'
    end
  end

  def unassign_users
    @crew = Crew.find(params[:id])
    @users = User.where(id: params[:user_ids])

    if @crew.users.exists?(id: @users.ids[0])
      redirect_to @crew, notice: "User is already in the team #{@crew.name}"
      authorize @crew
    else
      @crew.users << @users
      authorize @crew
      @crew.save
      redirect_to @crew, notice: 'Users were successfully assigned.'
    end
  end

  def unassign_user
    @crew = Crew.find(params[:id])
    @user = User.find(params[:user_id])
    @crew.users.delete(@user)
    authorize @crew

    redirect_to @crew, notice: 'User was successfully unassigned from the team.'
  end



  private

  def crew_params
    params.require(:crew).permit(:name)
  end

  def set_crew
    @crew = Crew.find(params[:id])
  end
end
