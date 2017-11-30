class Staff::CustomerSearchForm
  include ActiveModel::Model

  attr_accessor :family_name_kana,
                :given_name_kana,
                :birth_year,
                :birth_month,
                :birth_mday,
                :address_type,
                :prefecture,
                :city,
                :phone_number

  def search
    rel = Customer
    rel = search_by_name(rel)
    rel = search_by_date(rel)
    rel = search_by_address(rel)
    rel = search_by_phone(rel)

    rel.order(:family_name_kana, :given_name_kana)
  end

  private

  def search_by_name(rel)
    rel = rel.where(family_name_kana: family_name_kana) if family_name_kana.present?
    rel = rel.where(given_name_kana: given_name_kana) if given_name_kana.present?

    rel
  end

  def search_by_date(rel)
    rel = rel.where(birth_year: birth_year) if birth_year.present?
    rel = rel.where(birth_month: birth_month) if birth_month.present?
    rel = rel.where(birth_mday: birth_mday) if birth_mday.present?

    rel
  end

  def search_by_address(rel)
    return rel if prefecture.blank? && city.blank?

    case address_type
    when 'home'
      rel = rel.joins(:home_address)
    when 'work'
      rel = rel.joins(:work_address)
    when ''
      rel = rel.joins(:addresses)
    else
      raise
    end

    rel = rel.where('addresses.prefecture' => prefecture) if prefecture.present?
    rel = rel.where('address.city' => city) if city.present?

    rel
  end

  def search_by_phone(rel)
    return rel if phone_number.blank?
    rel.joins(:phones).where('phones.number_for_index' => phone_number)
  end
end
