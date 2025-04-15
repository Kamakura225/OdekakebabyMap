class ApplicationController < ActionController::Base
  GUEST_USER_EMAIL = "guest@example.com"


  helper_method :guest_user?
  def guest_user?
    current_user&.email == GUEST_USER_EMAIL
  end

end
