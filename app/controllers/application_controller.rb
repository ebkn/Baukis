class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  private

  def set_layout
    if params[:controller] =~ /\A(staff|admin|customer)/
      $1
    else
      'customer'
    end
  end
end
