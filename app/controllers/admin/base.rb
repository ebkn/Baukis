class Admin::Base < ApplicationController
  private

  def current_administrator
    return unless session[:administrator_id]

    @current_administrator ||=
      Administrator.find_by(id: session[:administrator_id])
  end

  helper_method :current_administrator
end
