class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :withdraw]
  before_action :ensure_correct_user, only: [:edit, :update, :withdraw]

  def show
    # @user = set_user でセット済み
    @bookmarked_places = @user.bookmarked_places
    @comments = @user.comments.includes(:place).order(created_at: :desc)
    @likes = @user.likes.includes(:likeable).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def withdraw
    @user.update(is_active: false)
    sign_out @user
    redirect_to root_path, notice: "退会処理が完了しました"
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to root_path, alert: "権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

end
