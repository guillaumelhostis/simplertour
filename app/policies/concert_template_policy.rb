class ConcertTemplatePolicy < ApplicationPolicy
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

  def import?
    true
  end

  def update_notes?
    true
  end

  def new_note?
    true
  end

  def delete_note?
    true
  end

  def update_timetable?
    true
  end

  def new_timetable?
    true
  end

  def delete_timetable?
    true
  end
end
