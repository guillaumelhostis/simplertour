class SidebarController < ApplicationController
  def tourman_sidebar
    @tours = policy_scope(Tour)
  end
end
