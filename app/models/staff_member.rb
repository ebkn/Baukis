class StaffMember < ApplicationRecord
  before_validation do
    self.email_for_index = email.downcase if email
  end
end
