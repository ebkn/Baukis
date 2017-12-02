class Staff::TopController < Staff::Base
  skip_before_action :authenticate_user

  def index
    render :dashboard if current_staff_member
  end
end
