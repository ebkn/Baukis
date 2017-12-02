class Staff::SessionsController < Staff::Base
  skip_before_action :authenticate_user

  def new
    if current_staff_member
      redirect_to staff_root_path
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

    staff_member = StaffMember.get_by_email(@form.email)
    if staff_member.nil?
      flash.now.alert = 'メールアドレスが間違っています'
    elsif staff_member.suspended
      staff_member.events.create!(type: 'rejected')
      flash.now.alert = 'アカウントが凍結されています'
    elsif Staff::Authenticator.new(staff_member).authenticate(@form.password)
      login(staff_member)
      return
    else
      flash.now.alert = 'パスワードが間違っています'
    end

    render :new
  end

  def destroy
    current_staff_member.events.create!(type: 'logged_out') if current_staff_member
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました'
    redirect_to staff_root_path
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
    staff_member.events.create!(type: 'logged_in')
    redirect_to staff_root_path, notice: 'ログインしました'
  end
end
