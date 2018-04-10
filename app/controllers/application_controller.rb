class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?
  rescue_from ApplicationController::Forbidden, with: :rescue403
  rescue_from ApplicationController::IpAddressRejected, with: :rescue403

  private

  def set_layout
    if params[:controller] =~ /\A(staff|admin|customer)/
      $1
    else
      'customer'
    end
  end

  def rescue403(exception)
    @exception = exception
    render 'errors/forbidden', status: :forbidden
  end
end
