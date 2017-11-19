class Staff::CustomersController < Staff::Base
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
