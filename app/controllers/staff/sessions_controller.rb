class Staff::SessionsController < Staff::Base
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

    staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)

    if staff_member.nil?
      flash.now.alert = 'メールアドレスが間違っています'
      render :new
    elsif Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      flash.notice = 'ログインしました'
      redirect_to staff_root_path
    elsif staff_member.suspended
      flash.now.alert = 'アカウントが凍結されています'
      render :new
    else
      flash.now.alert = 'パスワードが間違っています'
      render :new
    end
  end

  def destroy
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
end
