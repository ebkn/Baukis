class Admin::Base < ApplicationController
  before_action :authenticate_user, :check_account, :check_timeout

  private

  def current_administrator
    return unless session[:administrator_id]

    @current_administrator ||=
      Administrator.find_by(id: session[:administrator_id])
  end

  helper_method :current_administrator

  def authenticate_user
    unless current_administrator
      redirect_to admin_login_path, alert: 'ログインしてください'
    end
  end

  def check_account
    if current_administrator && current_administrator.suspended
      session.delete(:administrator_id)
      redirect_to admin_root_path, alert: 'アカウントが無効です'
    end
  end

  TIMEOUT = 60.minutes.freeze

  def check_timeout
    return unless current_administrator

    if session[:last_access_time] && session[:last_access_time] >= TIMEOUT.ago
      session[:last_access_time] = Time.current
    else
      session.delete(:administrator_id)
      redirect_to admin_login_path, alert: 'セッションがタイムアウトしました'
    end
  end
end
