class Admin::TopController < Admin::Base
  def index
    render :dashboard if current_administrator
  end
end
