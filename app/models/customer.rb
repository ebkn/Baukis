class Customer < ApplicationRecord
  include PersonalNameHolder
  include EmailHolder
  include PasswordHolder

  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  default_scope { order(:family_name_kana, :given_name_kana) }

  validates :gender, inclusion: { in: ['male', 'female', ''], allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: proc { Time.zone.today },
    allow_blank: true
  }
end
