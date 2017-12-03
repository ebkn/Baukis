class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  add_flash_types :success, :info, :warning, :danger

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  private

  def set_layout
    if params[:controller] =~ /\A(staff|admin|customer)/
      $1
    else
      'customer'
    end
  end
end
