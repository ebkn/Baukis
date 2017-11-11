class Staff::TopController < Staff::Base
  skip_before_action :authenticate_user

  def index; end
end
