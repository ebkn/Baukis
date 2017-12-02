class Customer < ApplicationRecord
  include PersonalNameHolder
  include EmailHolder
  include PasswordHolder

  has_many :addresses, dependent: :destroy
  has_one :home_address, autosave: true
  has_one :work_address, autosave: true
  has_many :phones, dependent: :destroy
  has_many :personal_phones, proc {
    where(address_id: nil)
  }, class_name: 'Phone', autosave: true

  default_scope { order(:family_name_kana, :given_name_kana) }

  before_validation do
    if birthday
      self.birth_year  = birthday.year
      self.birth_month = birthday.month
      self.birth_mday  = birthday.mday
    end
  end

  validates :gender, inclusion: { in: ['male', 'female', ''], allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: proc { Time.zone.today },
    allow_blank: true
  }
end
