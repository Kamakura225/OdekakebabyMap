class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  before_action :ensure_correct_user, only: [:show, :edit, :update, :withdraw]

  def show
    @user = User.find(params[:id])
    @bookmarked_places = @user.bookmarked_places
    @comments = @user.comments.includes(:place).order(created_at: :desc)
    @likes = @user.likes.includes(:likeable).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    sign_out @user
    redirect_to root_path, notice: "退会処理が完了しました"
  end

  def top_users
    @top_users = User.all.sort_by(&:total_good_likes).reverse.take(10)
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "権限がありません。"
    end
  end    

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :profile_image)
  end

end
