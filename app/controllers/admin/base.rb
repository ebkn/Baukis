class Admin::Base < ApplicationController
  before_action :check_source_ip_address,
                :authenticate_user,
                :check_account,
                :check_timeout

  private

  def check_source_ip_address
    raise IpAddressRejected unless AllowedSource.include?('admin', request.ip)
  end

  def current_administrator
    return unless session[:administrator_id]

    @current_administrator ||=
      Administrator.find_by(id: session[:administrator_id])
  end

  helper_method :current_administrator

  def authenticate_user
    return if current_administrator
    redirect_to admin_login_path, alert: 'ログインしてください'
  end

  def check_account
    return unless current_administrator&.suspended
    session.delete(:administrator_id)
    redirect_to admin_root_path, alert: 'アカウントが無効です'
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
