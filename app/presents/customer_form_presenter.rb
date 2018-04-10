class CustomerFormPresenter < UserFormPresenter
  GENDER_DISPLAY_NAMES = [
    { en: 'male', ja: '男性' }, { en: 'female', ja: '女性' }, { en: 'other', ja: 'その他' }
  ].freeze

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
        GENDER_DISPLAY_NAMES.each do |gender_hash|
          m.div(class: 'col-sm-3 col-md-2 form-check text-center') do
            m << radio_button(:gender, gender_hash[:en], class: 'form-check-input')
            m << label("gender_#{gender_hash[:en]}".to_sym, gender_hash[:ja], class: 'form-check-label')
          end
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
