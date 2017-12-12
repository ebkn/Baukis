class StaffMemberFormPresenter < UserFormPresenter
  def check_box_block
    markup(:div, class: 'form-check px-4 py-2') do |m|
      m << check_box(:suspended, class: 'form-check-input')
      m << label('アカウント停止', class: 'form-check-label px-0')
    end
  end
end
