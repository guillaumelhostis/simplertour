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

  def update_checkbox?
    true
  end

  def delete_checkbox?
    true
  end

  def new_checkbox?
    true
  end

  def update_transport?
    true
  end

  def delete_transport?
    true
  end

  def new_transport?
    true
  end

  def update_name?
    true
  end

  def delete_template?
    true
  end
end
