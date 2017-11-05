class Admin::StaffMembersController < Admin::Base
  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def new
    @staff_member = StaffMember.new
  end

  def create
    @staff_member = StaffMember.new(staff_member_params)
    if @staff_member.save
      redirect_to admin_staff_members_path, notice: '職員アカウントを新規登録しました'
    else
      flash.now.alert = '職員アカウントの登録に失敗しました'
      render :new
    end
  end

  def edit
    @staff_member = StaffMember.find(params[:id])
  end

  def update
    @staff_member = StaffMember.find(params[:id])
    if @staff_member.update(staff_member_params)
      redirect_to admin_staff_members_path, notice: '職員アカウントを更新しました'
    else
      flash.now.alert = '職員アカウントの更新に失敗しました'
      render :edit
    end
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to edit_admin_staff_member_path(staff_member)
  end

  def destroy
    staff_member = StaffMember.find(params[:id])
    staff_member.destroy!
    redirect_to admin_staff_members_path, notice: '職員アカウントを削除しました'
  end

  private

  def staff_member_params
    params.require(:staff_member).permit(
      :email,
      :password,
      :family_name,
      :given_name,
      :family_name_kana,
      :given_name_kana,
      :start_date,
      :end_date,
      :suspended
    )
  end
end
