class AddressPresenter < ModelPresenter
  def postal_code
    md = object.postal_code.match(/\A(\d{3})(\d{4})\z/)
    if md.present?
      md[1] + '-' + md[2]
    else
      object.postal_code
    end
  end

  def phones
    object.phones.map(&:number)
  end
end
