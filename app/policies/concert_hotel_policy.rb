class ConcertHotelPolicy < ApplicationPolicy
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

  def add_crew?
    true
  end

  def add_guest?
    true
  end

  def remove_user?
    true
  end

  def remove_guest?
    true
  end
end
