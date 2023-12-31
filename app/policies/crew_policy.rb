class CrewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def assign_users?
    true
  end

  def assign_users_role?
    true
  end

  def update_role_in_crew_member?
    true
  end


  def unassign_user?
    true
  end
end
