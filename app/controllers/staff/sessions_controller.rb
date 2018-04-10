class Staff::SessionsController < Staff::Base
  skip_before_action :authenticate_user

  def new
    if current_staff_member
      redirect_to staff_root_path, notice: '既にログイン済みです'
    else
      @form = Staff::LoginForm.new
    end
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)
    return false.tap { require_mail_and_password_flash } unless form_filled?(@form)

    staff_member = StaffMember.find_by!(email_for_index: @form.email.downcase)
    return false.tap { suspended_account_flash } if staff_member.suspended
    return false.tap { wrong_password_flash } unless check_password(staff_member)

    login(staff_member)
    redirect_to staff_root_path, notice: 'ログインしました'
  rescue ActiveRecord::RecordNotFound
    wrong_mail_flash
  end

  def destroy
    current_staff_member&.create_logout_events
    session.delete(:staff_member_id)
    redirect_to staff_root_path, notice: 'ログアウトしました'
  end

  private

  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end

  def form_filled?(form_data)
    form_data.email.present? && form_data.password.present?
  end

  def check_password(staff_member)
    Staff::Authenticator.new(staff_member).authenticate(@form.password)
  end

  def login(staff_member)
    session[:staff_member_id] = staff_member.id
    session[:last_access_time] = Time.current
    staff_member.create_login_events
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
