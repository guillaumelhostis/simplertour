class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:tech, :artist, :guest]
  after_initialize :set_default_role, :if => :new_record?
  has_many :crew_users
  has_many :crews, through: :crew_users
  has_many :transport_users
  has_many :transports, through: :transport_users



  def set_default_role
    self.role ||= :tech
  end

  def user_role_in_team(team, user)
    crew_user_entry = CrewUser.find_by({ crew_id: team.id, user_id: user.id })
    crew_user_entry ? crew_user_entry.role : nil
  end

  def full_name
    "#{first_name} #{last_name}"
  end


  private






end
