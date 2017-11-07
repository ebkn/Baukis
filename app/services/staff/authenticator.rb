class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
      !@staff_member.suspended &&
      @staff_member.hashed_password &&
      correct_date(@staff_member) &&
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end

  private

  def correct_date(staff_member)
    staff_member.start_date <= Time.zone.today &&
      (staff_member.end_date.nil? || @staff_member.end_date >= Time.zone.today)
  end
end
