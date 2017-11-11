class Admin::Base < ApplicationController
  before_action :authenticate_user

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
end
