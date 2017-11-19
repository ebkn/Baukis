class Staff::TopController < Staff::Base
  skip_before_action :authenticate_user

  def index
    if current_staff_member
      render :dashboard
    else
      render :index
    end
  end
end
