class AllowedSource < ApplicationRecord
  validates :octet1,
            :octet2,
            :octet3,
            :octet4,
            presence: true,
            numericality: { only_integer: true, allow_blank: true },
            inclusion: { in: 0..255, allow_blank: true }
  validates :octet4,
            uniqueness: { scope: %i[octet1 octet2 octet3], allow_blank: true }
end
