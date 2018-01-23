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
    unless form_filled?(@form)
      flash.now.alert = 'メールアドレスとパスワードを入力してください'
      render :new
      return
    end

    staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    if staff_member.nil?
      flash.now.alert = 'メールアドレスが間違っています'
      render :new
    elsif staff_member.suspended
      staff_member.create_rejected_events
      flash.now.alert = 'アカウントが凍結されています'
      render :new
    elsif Staff::Authenticator.new(staff_member).authenticate(@form.password)
      login(staff_member)
      redirect_to staff_root_path, notice: 'ログインしました'
    else
      flash.now.alert = 'パスワードが間違っています'
      render :new
    end
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

  def login(staff_member)
    session[:staff_member_id] = staff_member.id
    session[:last_access_time] = Time.current
    staff_member.create_login_events
  end
end
