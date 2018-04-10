class Admin::SessionsController < Admin::Base
  skip_before_action :authenticate_user

  def new
    if current_administrator
      redirect_to admin_root_path, notice: '既にログインしています'
    else
      @form = Admin::LoginForm.new
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    return false.tap { require_mail_and_password_flash } unless form_filled?(@form)

    administrator = Administrator.find_by!(email_for_index: @form.email.downcase)
    return false.tap { suspended_account_flash } if administrator.suspended
    return false.tap { wrong_password_flash } unless check_password(administrator)

    login(administrator)
    redirect_to admin_root_path, notice: 'ログインしました'
  rescue ActiveRecord::RecordNotFound
    wrong_mail_flash
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

  def check_password(administrator)
    Admin::Authenticator.new(administrator).authenticate(@form.password)
  end

  def login(administrator)
    session[:administrator_id] = administrator.id
    session[:last_access_time] = Time.current
  end

  def require_mail_and_password_flash
    flash.now.alert = 'メールアドレスとパスワードを入力してください'
    render :new
  end

  def wrong_mail_flash
    flash.now.alert = 'メールアドレスが間違っています'
    render :new
  end

  def suspended_account_flash
    flash.now.alert = 'アカウントが凍結されています'
    render :new
  end

  def wrong_password_flash
    flash.now.alert = 'パスワードが間違っています'
    render :new
  end
end
