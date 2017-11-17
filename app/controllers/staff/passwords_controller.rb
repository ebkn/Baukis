class Staff::PasswordsController < Staff::Base
  def show
    redirect_to edit_staff_password_path
  end

  def edit
    @change_password_form =
      Staff::ChangePasswordForm.new(object: current_staff_member)
  end

  def update
    @change_password_form =
      Staff::ChangePasswordForm.new(staff_change_password_params)
  end

  private

  def staff_change_password_params
    params.require(:staff_change_password_form).permit(
      :current_password,
      :new_password,
      :new_password_confirmation
    )
  end
end
