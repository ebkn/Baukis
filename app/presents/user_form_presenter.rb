class UserFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    if object.new_record?
      super(name, label_text, options)
    else
      markup(:div, class: 'form-group py-2') do |m|
        m << decorated_label(name, label_text, options.merge(required: false))
        m.button('変更する', type: 'button', id: 'enable-password_field-button')
        m.button('変更しない', type: 'button', id: 'disable-password_field-button')
        m << password_field(name, options.merge(disabled: true))
        m << error_messages_for(name)
      end
    end
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: 'form-group py-2') do |m|
      m << decorated_label(name1, label_text, options)
      m.div(class: 'form-row') do
        m.div(class: 'col') do
          m << text_field(
            name1,
            options.merge(class: 'form-control', placeholder: 'Family name')
          )
        end
        m.div(class: 'col') do
          m << text_field(
            name2,
            options.merge(class: 'form-control', placeholder: 'Given name')
          )
        end
      end
      m << error_messages_for(name1)
      m << error_messages_for(name2)
    end
  end
end
