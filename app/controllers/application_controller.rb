class ApplicationController < ActionController::Base
  before_action :basic
  before_action :login_required
  helper_method :current_user

  private
  def basic
    if Rails.env == "production"
      authenticate_or_request_with_http_basic do |name, password|
        name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def admin_required
    redirect_to tasks_url unless current_user.admin?
    flash[:danger] = '管理者権限が必要です'
  end
end
