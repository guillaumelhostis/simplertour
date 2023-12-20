class CrewCreationService

  def initialize(user_params, crew)
    @user_params = user_params
    @crew = crew
    @success = false
  end

  def call
    find_user
    build_crew_user if find_user
  end

  def success
    @success
  end

  def user
    @user.full_name
  end

  private

  def find_user
    unless @user_params.nil?
      @user = User.find(@user_params.first)
    end
  end

  def build_crew_user
    unless @crew.users.exists?(id: @user.id)
      @crew_user = CrewUser.create(user: @user, crew: @crew, role: "Tech")
      @success = @crew_user.save
    end
  end
end
