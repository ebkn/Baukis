class Customer::Base < ApplicationController
  before_action :authenticate_user

  private

  def current_customer
    customer_id = cookies.signed[:customer_id] || session[:customer_id]
    return if customer_id.blank?

    @current_customer ||= Customer.find_by(id: customer_id)
  end

  helper_method :current_customer

  def authenticate_user
    return if current_customer
    redirect_to customer_login_path, alert: 'ログインしてください'
  end
end
