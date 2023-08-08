class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:tech, :artist, :guest]
  after_initialize :set_default_role, :if => :new_record?
  has_many :crew_users
  has_many :crews, through: :crew_users


  def set_default_role
    self.role ||= :tech
  end

  def user_role_in_team(team)
    crew_user_entry = CrewUser.find_by(crew_id: team.id)
    raise

    crew_user_entry ? team_user_entry.role : nil
  end

  private






end
