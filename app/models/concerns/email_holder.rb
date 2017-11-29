module EmailHolder
  extend ActiveSupport::Concern

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

  included do
    include StringNormalizer

    before_validation do
      self.email            = normalize_as_email(email)
      self.email_for_index  = email.downcase if email
    end

    validates :email, presence: true,
    format: { with: VALID_EMAIL_REGEX, allow_blank: true }
    validates :email_for_index, uniqueness: true

    after_validation do
      if errors.include?(:email_for_index)
        errors.add(:email, :taken)
        errors.delete(:email_for_index)
      end
    end
  end
end
