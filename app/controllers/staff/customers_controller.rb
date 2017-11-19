class Staff::CustomersController < Staff::Base
  def index
    @customers = Customer.page(params[:page])
  end
end
