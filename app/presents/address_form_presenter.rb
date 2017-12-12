class AddressFormPresenter < FormPresenter
  def postal_code_block(name, options)
    markup(:div, class: 'form-group py-2') do |m|
      m << text_field_block(name, options)
      m.div '7桁以上の半角数字で入力してください', class: 'notes'
      m << error_messages_for(name)
    end
  end
end
