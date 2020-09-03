class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    if params[:sort] == 'deadline'
      @tasks = Task.all.order(deadline: 'DESC')
    else
      @tasks = Task.all.order(created_at: 'DESC')
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: t('view.notice.create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: t('view.notice.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('view.notice.destroy')
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :status)
  end
end
