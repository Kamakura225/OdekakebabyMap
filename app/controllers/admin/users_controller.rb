class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def freeze
    @user = User.find(params[:id])
    @user.update(active: false)
    redirect_to admin_users_path, notice: 'ユーザーが凍結されました！'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: '管理者以外アクセスできません' unless current_user.admin?
  end
end
