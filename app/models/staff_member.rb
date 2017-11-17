class StaffMember < ApplicationRecord
  include StringNormalizer

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  default_scope { order(:family_name_kana, :given_name_kana) }

  before_validation do
    self.email            = normalize_as_email(email)
    self.email_for_index  = email.downcase if email
    self.family_name      = normalize_as_name(family_name)
    self.given_name       = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana  = normalize_as_furigana(given_name_kana)
  end

  VALID_EMAIL_REGEX    = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_NAME_REGEX     = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}A-Za-z]+\z/
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX, allow_blank: true }
  validates :email_for_index, uniqueness: true
  validates :family_name, :given_name, presence: true,
                                       format: { with: VALID_NAME_REGEX, allow_blank: true }
  validates :family_name_kana, :given_name_kana, presence: true,
                                                 format: { with: VALID_KATAKANA_REGEX, allow_blank: true }
  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2017, 1, 1),
    before: proc { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: proc { 1.year.from_now.to_date },
    allow_blank: true
  }

  after_validation do
    if errors.include?(:email_for_index)
      errors.add(:email, :token)
      errors.delete(:email_for_index)
    end
  end

  def password=(raw_password)
    if raw_password.is_a?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended &&
      start_date <= Time.zone.today &&
      (end_date.nil? || end_date > Time.zone.today)
  end

  def full_name
    "#{family_name} #{given_name}"
  end

  def full_name_kana
    "#{family_name_kana} #{given_name_kana}"
  end
end
