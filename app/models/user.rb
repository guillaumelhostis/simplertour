class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:tech, :artist, :guest]
  after_initialize :set_default_role, :if => :new_record?
  has_and_belongs_to_many :crews


  def set_default_role
    self.role ||= :tech
  end

  private



end
