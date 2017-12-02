class StaffMember < ApplicationRecord
  include StringNormalizer
  include PersonalNameHolder
  include EmailHolder
  include PasswordHolder

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  default_scope { order(:family_name_kana, :given_name_kana) }

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

  def active?
    !suspended &&
      start_date <= Time.zone.today &&
      (end_date.nil? || end_date > Time.zone.today)
  end

  def create_rejected_events
    events.create!(type: 'rejected')
  end

  def create_login_events
    events.create!(type: 'logged_in')
  end

  def create_logout_events
    events.create!(type: 'logged_out')
  end
end
