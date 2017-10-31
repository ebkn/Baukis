class Admin::SessionsController < ApplicationController
  def index
    redirect_to :admin_login
  end

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LginForm.new
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)

    if form_filled?(@form)
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)

      if administrator.suspended
        flash.now.alert = 'アカウントが乙結されています'
        render :new
      elsif Admin::Authenticator.new(administrator).authenticate(@form.password)
        session[:administrator_id] = administrator.id
        flash.notice = 'ログインしました'
        redirect_to admin_root_path
      else
        flash.now.alert = 'メールアドレスまたはパスワードが間違っています'
        render :new
      end
    else
      flash.now.alert = 'メールアドレスとパスワードを入力してください'
      render :new
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'ログアウトしました'
    redirect_to admin_root_path
  end

  private

  def login_form_params
    params.require(:admin_login_form).permit(:email, :password)
  end

  def form_filled?(form_data)
    form_data.email.present? && form_data.password.present?
  end
end
