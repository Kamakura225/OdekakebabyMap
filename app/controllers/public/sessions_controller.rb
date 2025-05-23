# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  GUEST_USER_EMAIL = "guest@example.com"
  def guest_sign_in
    user = User.find_or_create_by!(email: GUEST_USER_EMAIL) do |u|
      u.password = SecureRandom.urlsafe_base64
      u.nickname = 'ゲストユーザー'
    end

    sign_in user
    redirect_to places_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  
end
