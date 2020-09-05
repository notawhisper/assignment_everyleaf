class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    if params[:task].present?
      if params[:task][:search_for_title].present? && params[:task][:search_for_status].present?
        @tasks = Task.search_for_title(params[:task][:search_for_title]).search_for_status(params[:task][:search_for_status]).page(params[:page]).per(10)
      elsif params[:task][:search_for_title].present?
        @tasks = Task.search_for_title(params[:task][:search_for_title]).page(params[:page]).per(10)
      elsif params[:task][:search_for_status].present?
        @tasks = Task.search_for_status(params[:task][:search_for_status]).page(params[:page]).per(10)
      end
    else
      @tasks = Task.all.order(created_at: 'DESC').page(params[:page]).per(10)
    end

    if params[:sort] == 'deadline'
      @tasks = Task.all.order(deadline: 'DESC').page(params[:page]).per(10)
    elsif params[:sort] == 'priority'
      @tasks = Task.all.order(priority: 'DESC').page(params[:page]).per(10)
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
    params.require(:task).permit(:title, :description, :deadline, :status, :priority, :user_id)
  end
end
