class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :approve, :make_owner]

  def index
    @users = User.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def approve
    @user.update(approved: true)
    redirect_to admin_users_path, notice: "User approved."
  end

  def make_owner
    @user.update(role: :owner)
    redirect_to admin_user_path(@user), notice: "User now owner."
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
