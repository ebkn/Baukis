class Staff::Base < ApplicationController
  before_action :authenticate_user, :check_account, :check_timeout

  private

  def current_staff_member
    return unless session[:staff_member_id]

    @current_staff_member ||=
      StaffMember.find_by(id: session[:staff_member_id])
  end

  helper_method :current_staff_member

  def authenticate_user
    unless current_staff_member
      redirect_to staff_login_path, alert: 'ログインしてください'
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      redirect_to staff_root_path, alert: 'アカウントが無効です'
    end
  end

  TIMEOUT = 60.minutes.freeze

  def check_timeout
    return unless current_staff_member

    if session[:last_access_time] && session[:last_access_time] >= TIMEOUT.ago
      session[:last_access_time] = Time.current
    else
      session.delete(:staff_member_id)
      redirect_to staff_login_path, alert: 'セッションがタイムアウトしました'
    end
  end
end
