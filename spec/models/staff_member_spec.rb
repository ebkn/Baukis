require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe '#password=' do
    it 'make hashed_password 60 characters' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end
  end
end
