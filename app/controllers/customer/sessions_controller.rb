class Customer::SessionsController < Customer::Base
  skip_before_action :authenticate_user

  def new
    if current_customer
      redirect_to customer_root_path
    else
      @form = Customer::LoginForm.new
    end
  end

  def create
    @form = Customer::LoginForm.new(login_form_params)
    unless form_filled?(@form)
      flash.now.alert = 'メールアドレスとパスワードを入力してください'
      render :new
      return
    end

    customer = Customer.find_by(email_for_index: @form.email.downcase)
    if customer.nil?
      flash.now.alert = 'メールアドレスが間違っています'
      render :new
    elsif Customer::Authenticator.new(customer).authenticate(@form.password)
      check_remember_me(@form.remember_me?, customer)
      redirect_to customer_root_path, notice: 'ログインしました'
    else
      flash.now.alert = 'パスワードが間違っています'
      render :new
    end
  end

  def destroy
    session.delete(:customer_id)
    cookies.delete(:customer_id)
    redirect_to customer_root_path, notice: 'ログアウトしました'
  end

  private

  def login_form_params
    params.require(:customer_login_form).permit(:email, :password, :remember_me)
  end

  def form_filled?(form_data)
    form_data.email.present? && form_data.password.present?
  end

  def check_remember_me(remember_me, customer)
    if remember_me
      cookies.permanent.signed[:customer_id] = {
        value: customer.id,
        expires: 1.week.from_now
      }
    else
      cookies.delete(:customer_id)
      session[:customer_id] = customer.id
    end
  end
end
