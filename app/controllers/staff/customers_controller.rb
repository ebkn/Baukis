class Staff::CustomersController < Staff::Base
  def index
    @search_form = Staff::CustomerSearchForm.new
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer_form = Staff::CustomerForm.new
  end

  def create
    @customer_form = Staff::CustomerForm.new
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      redirect_to staff_customers_path, notice: '顧客を追加しました'
    else
      flash.now.alert = '入力に誤りがあります'
      render :new
    end
  end

  def edit
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
  end

  def update
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      redirect_to staff_customers_path, notice: '顧客情報を更新しました'
    else
      flash.now.alert = '入力に誤りがあります'
      render :edit
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    redirect_to staff_customers_path, notice: '顧客アカウントを削除しました'
  end
end
