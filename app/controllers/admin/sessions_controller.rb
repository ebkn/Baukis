class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to admin_root_path
    else
      @form = Admin::LoginForm.new
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    unless form_filled?(@form)
      flash.now.alert = 'メールアドレスとパスワードを入力してください'
      render :new
      return
    end

    administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    if administrator.nil?
      flash.now.alert = 'メールアドレスが間違っています'
    elsif administrator.suspended
      flash.now.alert = 'アカウントが凍結されています'
    elsif Admin::Authenticator.new(administrator).authenticate(@form.password)
      session[:administrator_id] = administrator.id
      redirect_to admin_root_path, notice: 'ログインしました'
      return
    else
      flash.now.alert = 'パスワードが間違っています'
    end

    render :new
  end

  def destroy
    session.delete(:administrator_id)
    redirect_to admin_root_path, notice: 'ログアウトしました'
  end

  private

  def login_form_params
    params.require(:admin_login_form).permit(:email, :password)
  end

  def form_filled?(form_data)
    form_data.email.present? && form_data.password.present?
  end
end
