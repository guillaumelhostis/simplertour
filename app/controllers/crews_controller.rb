class CrewsController < ApplicationController
  before_action :set_crew, only: [:show, :assign_users, :assign_users_role, :update_role_in_crew_member, :unassign_user]
  before_action :set_tours_and_concert_templates, only: [:show]

  def show
    @users = User.all
    @crew_users = CrewUser.where(crew_id: @crew).order(created_at: :asc)
    @tour = Tour.find_by(crew_id: @crew.id)
  end

  def assign_users
    service = CrewCreationService.new(params[:user_ids], @crew)
    service.call
    if service.success
      redirect_to @crew, notice: "#{service.user} were successfully assigned"
    else
      redirect_to @crew, notice: 'Something went wrong'
    end
  end

  def assign_users_role
    @crewuser = CrewUser.find_by(user_id: params[:format], crew_id: params[:id] )
    role = params[:role]
    if @crewuser.update(role: role)
      render json: { success: true, role: @crewuser.role }
    else
      render json: { success: false, errors: @crewuser.errors.full_messages }
    end
  end

  def update_role_in_crew_member
    @crewuser = CrewUser.find_by(user_id: params[:user_id], crew_id: params[:id] )
    @crewuser.role = nil
    if @crewuser.save
      render json: { success: true, role: @crewuser.role }
    else
      render json: { success: false, errors: @crewuser.errors.full_messages }
    end
  end

  def unassign_user
    @crew_user = CrewUser.find(params[:user_id])
    if @crew_user.destroy
      redirect_to @crew, notice: 'User was successfully unassigned from the team.'
    else
      redirect_to @crew, notice: "Couldn't destroy this user."
    end
  end

  private

  def set_crew
    @crew = Crew.find_by(id: params[:id])
    if @crew.present?
      authorize @crew
    else
      redirect_to tours_path, notice: "Something went wrong"
    end
  end

  def set_tours_and_concert_templates
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
  end
end
