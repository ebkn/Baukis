class CustomerFormPresenter < UserFormPresenter
  def birthday_field_block(name, label_text, options = {})
    markup(:div, class: 'generic_form-input') do |m|
      m << decorated_label(name, label_text, options)
      options = insert_birthday_picker(options)
      m << text_field(name, options)
      m << error_messages_for(name)
    end
  end

  def gender_field_block
    markup(:div, class: 'generic_form-input') do |m|
      m << decorated_label(:gender, '性別')
      m << radio_button(:gender, 'male')
      m << label(:gender_male, '男性', class: 'gender')
      m << radio_button(:gender, 'female')
      m << label(:gender_female, '女性', class: 'gender')
      m << radio_button(:gender, 'other')
      m << label(:gender_other, 'その他', class: 'gender')
      m << error_messages_for(:gender)
    end
  end

  private

  def insert_birthday_picker(options)
    if options[:class].is_a?(String)
      classes = options[:class].strip.split + ['birthday-picker']
      options[:class] = classes.uniq.join(' ')
    else
      options[:class] = 'birthday-picker'
    end

    options
  end
end
