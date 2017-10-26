require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe '#password=' do
    it 'creates 60 characters hashed_password' do
      member = StaffMember.new
      member.password = Faker::Superhero.name
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    it 'creates nil hashed_password' do
      member = StaffMember.new
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
