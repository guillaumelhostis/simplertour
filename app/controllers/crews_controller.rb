class CrewsController < ApplicationController
  before_action :set_crew, only: [:show, :edit, :update, :destroy]


  def index
    @crews = policy_scope(Crew)
  end

  def show
    @tours = Tour.where(tourman_id: current_tourman.id)
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    authorize @crew
    @users = User.all
    @crew_users = CrewUser.where(crew_id: @crew).order(created_at: :asc)


    @tour = Tour.find_by(crew_id: @crew.id)
  end


  def assign_users
    @crew = Crew.find(params[:id])
    @users = User.where(id: params[:user_ids])

    role = params[:role]

    if @crew.users.exists?(id: @users.ids[0])
      redirect_to @crew, notice: "User is already in the team #{@crew.name}"
      authorize @crew
    else
      @users.each do |user|
        new_crew_user = CrewUser.create(user: user, crew: @crew, role: role)
        tour = Tour.find_by(crew_id: @crew.id )
        concerts= tour.concerts
        concerts.each do |concert|
          CrewUserConcert.create(concert_id: concert.id, crew_user_id: new_crew_user.id )
        end
      end
      authorize @crew
      @crew.save
      redirect_to @crew, notice: 'Users were successfully assigned.'
    end
  end

  def assign_users_role

    @crew = Crew.find(params[:id])

    @crewuser = CrewUser.find_by(user_id: params[:format], crew_id: params[:id] )


    role = params[:role]

    authorize @crew
    if @crewuser.update(role: role)
      render json: { success: true, message: 'Role updated successfully', role: @crewuser.role }
    else
      render json: { success: false, errors: @crewuser.errors.full_messages }
    end
  end

  def update_role_in_crew_member


    @crew = Crew.find(params[:id])
    @crewuser = CrewUser.find_by(user_id: params[:user_id], crew_id: params[:id] )
    @crewuser.role = nil
    authorize @crew

    if @crewuser.save
      render json: { success: true, message: 'Role updated successfully', role: @crewuser.role }
    else
      render json: { success: false, errors: @crewuser.errors.full_messages }
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

  def assign_role_to_user_in_crew(user, crew, role)
    user_crew_entry = user_crews_entry(user, crew)
    user_crew_entry.update(role: role) if user_crew_entry
  end

  def user_crews_entry(user, crew)
    User.connection.execute("
      SELECT * FROM crews_users
      WHERE user_id = #{user.id} AND crew_id = #{crew.id}
      LIMIT 1
    ").first
  end

end
