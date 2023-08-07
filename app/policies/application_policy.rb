# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :request_tourman

  def initialize(authorization_context, record)
    @user = authorization_context.user
    @tourman = authorization_context.tourman
    @record = record

  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
