class UserFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    return super(name, label_text, options) if object.new_record?

    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(name, label_text, options.merge(required: false))
      change_password_button(m)
      not_change_password_button(m)
      m << password_field(name, options.merge(disabled: true,
                                              class: 'form-control',
                                              style: 'display: none;'))
      m << error_messages_for(name)
    end
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(name1, label_text, options)
      m.div(class: 'form-row') do
        m.div(class: 'col') do
          m << text_field(name1, options.merge(class: 'form-control',
                                               placeholder: 'Family name'))
          m << error_messages_for(name1)
        end
        m.div(class: 'col') do
          m << text_field(name2, options.merge(class: 'form-control',
                                               placeholder: 'Given name'))
          m << error_messages_for(name2)
        end
      end
    end
  end

  private

  def change_password_button(m)
    m.button('変更する',
             type: 'button',
             class: 'btn btn-raised btn-warning mx-3',
             id: 'enable-password_field-button')
  end

  def not_change_password_button(m)
    m.button('変更しない',
             type: 'button',
             id: 'disable-password_field-button',
             class: 'btn btn-raised btn-primary mx-3',
             style: 'display: none')
  end
end
