class CustomerFormPresenter < UserFormPresenter
  def birthday_field_block(name, options = {})
    markup(:div, class: 'form-group py-2') do |m|
      options = insert_birthday_picker(options)
      m << text_field_block(name, options)
      m << error_messages_for(name)
    end
  end

  def gender_field_block
    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(:gender, '性別')
      m.div(class: 'form-row px-3') do
        m.div(class: 'col-sm-3 col-md-2 form-check text-center') do
          m << radio_button(:gender, 'male', class: 'form-check-input')
          m << label(:gender_male, '男性', class: 'form-check-label')
        end
        m.div(class: 'col-sm-3 col-md-2 form-check text-center') do
          m << radio_button(:gender, 'female', class: 'form-check-input')
          m << label(:gender_female, '女性', class: 'form-check-label')
        end
        m.div(class: 'col-sm-3 col-md-2 form-check text-center') do
          m << radio_button(:gender, 'other', class: 'form-check-input')
          m << label(:gender_other, 'その他', class: 'form-check-label')
        end
        m << error_messages_for(:gender)
      end
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
