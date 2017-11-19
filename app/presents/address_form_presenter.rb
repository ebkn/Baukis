class AddressFormPresenter < FormPresenter
  def postal_code_block(name, label_text, options)
    markup(:div, class: 'generic_form-input') do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, options)
      m.div '7桁以上の半角数字で入力してください', class: 'notes'
      m << error_messages_for(name)
    end
  end
end
