class TourPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(tourman_id: user.tourman.id)
    end

  end

  def show?
    record.tourman_id == @tourman.id
  end

  def create?
    true
  end

  def update?
    record.tourman_id == @tourman.id
  end

  def destroy?
    record.tourman_id == @tourman.id
  end


end
