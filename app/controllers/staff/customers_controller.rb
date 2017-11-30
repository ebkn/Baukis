class Staff::CustomersController < Staff::Base
  def index
    @search_form = Staff::CustomerSearchForm.new(search_params)
    @customers = @search_form.search.page(params[:page])
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

  private

  def search_params
    return nil unless params[:search]
    params.require(:search).permit(
      :family_name_kana,
      :given_name_kana,
      :gender,
      :birth_year,
      :birth_month,
      :birth_mday,
      :postal_code,
      :address_type,
      :prefecture,
      :city,
      :phone_number,
      :last_four_digits_of_phone_number
    )
  end
end
