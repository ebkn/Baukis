class StaffMemberPresenter < ModelPresenter
  delegate :suspended, to: :object

  def suspended_status
    suspended ? '停止中' : ''
  end
end
