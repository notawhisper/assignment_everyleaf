class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    if session[:user_id]
      redirect_to user_url(id: session[:user_id])
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    if params[:id].to_i == current_user.id
      @user = User.find_by(id: current_user.id)
    else
      redirect_to tasks_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
