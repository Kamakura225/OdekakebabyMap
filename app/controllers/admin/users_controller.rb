class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where.not(email: "guest@example.com")
  end

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.includes(:place).order(created_at: :desc)
    @places = @user.places.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render :show, alert: "更新に失敗しました"
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :is_active)
  end

  def active_for_authentication?
    super && is_active?
  end
end
