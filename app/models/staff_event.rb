class StaffEvent < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :member, class_name: 'StaffMember', foreign_key: :staff_member_id

  alias_attribute :occured_at, :created_at

  default_scope { order(occured_at: :desc) }

  DESCRIPTIONS = {
    logged_in:  'ログイン',
    logged_out: 'ログアウト',
    rejected:   'ログイン拒否'
  }.freeze

  def description
    DESCRIPTIONS[type.to_sym]
  end
end
