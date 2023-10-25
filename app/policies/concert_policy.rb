class ConcertPolicy < ApplicationPolicy
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

  def removetimetable?
    true
  end

  def remove_contact?
    true
  end

  def generate_pdf?
    true
  end

  def roadbook_email?
    true
  end
end
