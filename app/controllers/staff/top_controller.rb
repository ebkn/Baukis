class Staff::TopController < Staff::Base
  skip_before_action :before_action

  def index; end
end
