class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
<<<<<<< HEAD
    @users = User.all
=======
    @users = User.where.not(email: "guest@example.com")
>>>>>>> develop
  end

  def show
    @user = User.find(params[:id])
<<<<<<< HEAD
  end

  def freeze
    @user = User.find(params[:id])
    @user.update(active: false)
    redirect_to admin_users_path, notice: 'ユーザーが凍結されました！'
=======
    @comments = @user.comments.includes(:place).order(created_at: :desc)
    @places = @user.places.order(created_at: :desc)

    @good_count = Like.where(likeable_type: "Comment", reaction_type: "good", likeable_id: Comment.where(user_id: @user.id)).count
    @bad_count = Like.where(likeable_type: "Comment", reaction_type: "bad", likeable_id: Comment.where(user_id: @user.id)).count
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
>>>>>>> develop
  end

  private

<<<<<<< HEAD
  def authenticate_admin!
    redirect_to root_path, alert: '管理者以外アクセスできません' unless current_user.admin?
=======
  def user_params
    params.require(:user).permit(:nickname, :is_active)
  end

  def active_for_authentication?
    super && is_active?
>>>>>>> develop
  end
end
