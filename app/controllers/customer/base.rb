class Customer::Base < ApplicationController
  before_action :authenticate_user

  private

  def current_customer
    return unless session[:customer_id]
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  helper_method :current_customer

  def authenticate_user
    return if current_customer
    redirect_to customer_login_path, alert: 'ログインしてください'
  end
end
