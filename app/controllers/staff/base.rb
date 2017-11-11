class Staff::Base < ApplicationController
  before_action :authenticate_user

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
end
