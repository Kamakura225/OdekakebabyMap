class ApplicationController < ActionController::Base
  GUEST_USER_EMAIL = "guest@example.com"
  # before_action : restrict_ip_for_admin!


  helper_method :guest_user?
  def guest_user?
    current_user&.email == GUEST_USER_EMAIL
  end

  

  private

  def restrict_ip_for_admin
    # admin配下だけ制限
    if request.path.start_with?('/admin')
      allowed_ips = ENV['ADMIN_IP'].to_s
      unless allowed_ips.include?(request.remote_ip)
        redirect_to root_path
      end
    end
  end
end
