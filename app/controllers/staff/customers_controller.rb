class Staff::CustomersController < Staff::Base
  def index
    @search_form = Staff::CustomerSearchForm.new(search_params)
    @customers = @search_form.search.order_by_name.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    set_new_customer_form
  end

  def create
    set_new_customer_form
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      redirect_to staff_customers_path, notice: '顧客を追加しました'
    else
      flash.now.alert = '入力に誤りがあります'
      render :new
    end
  end

  def edit
    set_selected_customer_form
  end

  def update
    set_selected_customer_form
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

  private

  def search_params
    return nil unless params[:search]
    params.require(:search).permit(
      :family_name_kana, :given_name_kana,
      :gender,
      :birth_year, :birth_month, :birth_mday,
      :address_type,
      :postal_code, :prefecture, :city,
      :phone_number, :last_four_digits_of_phone_number
    )
  end

  def set_new_customer_form
    @customer_form = Staff::CustomerForm.new
  end

  def set_selected_customer_form
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
  end
end
