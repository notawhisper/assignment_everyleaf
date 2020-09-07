class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: current_user.id)
  end
end
