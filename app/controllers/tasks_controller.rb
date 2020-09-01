class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit]
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
  end

  def edit
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end
end
