class Customer < ApplicationRecord
  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  default_scope { order(:family_name_kana, :given_name_kana) }

  before_validation do
    self.email_for_index = email.downcase if email
  end

  validates :gender, inclusion: { in: ['male', 'female', ''], allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: proc { Time.zone.today },
    allow_blank: true
  }

  def password=(raw_password)
    if raw_password.is_a?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
