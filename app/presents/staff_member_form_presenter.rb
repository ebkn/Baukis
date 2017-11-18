class StaffMemberFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    super(name, label_text, options) if object.new_record?
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: 'generic_form-input') do |m|
      m << decorated_label(name1, label_text, options)
      options[:placeholder] = 'Family name'
      m << text_field(name1, options)
      options[:placeholder] = 'Given name'
      m << text_field(name2, options)
      m << error_messages_for(name1)
      m << error_messages_for(name2)
    end
  end

  def check_box_block
    markup(:div, class: 'generic_form-input') do |m|
      m << check_box(:suspended)
      m << label(:suspend, 'アカウント停止')
    end
  end
end
