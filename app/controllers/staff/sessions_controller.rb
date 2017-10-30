class Staff::SessionsController < Staff::Base
  def index
    redirect_to :staff_login
  end

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render :new
    end
  end

  def create
    @form = Staff::LoginForm.new(login_form_params)

    if form_filled?(@form)
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)

      if staff_member.suspended
        flash.now.alert = 'アカウントが凍結されています'
        render :new
      elsif Staff::Authenticator.new(staff_member).authenticate(@form.password)
        session[:staff_member_id] = staff_member.id
        flash.notice = 'ログインしました'
        redirect_to staff_root_path
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
