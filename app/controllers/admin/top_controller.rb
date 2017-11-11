class Admin::TopController < Admin::Base
  skip_before_action :authenticate_user

  def index
    render :dashboard if current_administrator
  end
end
