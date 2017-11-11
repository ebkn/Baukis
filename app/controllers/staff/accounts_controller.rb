class Staff::AccountsController < Staff::Base
  before_action :set_current_staff_member

  def show; end

  def edit; end

  def update
    if @staff_member.update(staff_member_params)
      redirect_to staff_account_path, notice: 'アカウント情報を更新しました'
    else
      flash.now.alert = 'アカウント情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def set_current_staff_member
    @staff_member = current_staff_member
  end

  def staff_member_params
    params.require(:staff_member).permit(
      :email,
      :family_name,
      :given_name,
      :family_name_kana,
      :given_name_kana
    )
  end
end
