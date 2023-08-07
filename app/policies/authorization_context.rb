class AuthorizationContext
  attr_reader :user, :tourman

  def initialize(user, tourman)
    @user = user
    @tourman = tourman
  end
end
