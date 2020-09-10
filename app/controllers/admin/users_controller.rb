class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :admin_required

  def index
    # @users = User.select(:id, :name, :email, :admin, :created_at, :updated_at)
    # @tasks = Task.all.includes(:user)
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_url(@user)
    else
      render :edit
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
