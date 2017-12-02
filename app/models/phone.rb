class Phone < ApplicationRecord
  include StringNormalizer

  belongs_to :customer, optional: true
  belongs_to :address, optional: true

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/, '') if number
    self.last_four_digits = number_for_index[-4, 4] if number_for_index
    self.customer = address.customer if address
  end

  VALID_PHONE_NUMBER = /\A\+?\d+(-\d+)*\z/

  validates :number, presence: true,
                     format: { with: VALID_PHONE_NUMBER, allow_blank: true }
end
