class VenuePolicy < ApplicationPolicy
  class Scope < Scope
      def resolve
        scope.where(tourman_id: user.tourman.id)
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
end
