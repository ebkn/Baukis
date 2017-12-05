class StaffMemberFormPresenter < UserFormPresenter
  def check_box_block
    markup(:div, class: 'form-group py-2') do |m|
      m << check_box(:suspended)
      m << label(:suspend, 'アカウント停止')
    end
  end
end
