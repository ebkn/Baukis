require 'spec_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    def is_authenticated(staff_member, password)
      Staff::Authenticator.new(staff_member).authenticate(password)
    end

    before(:each) do
      @password = Faker::Internet.password
    end

    context 'when true' do
      it 'returns true when correct password' do
        staff_member = build(:staff_member, password: @password)
        expect(is_authenticated(staff_member, @password)).to be true
      end

      it 'returns true when end_date is nil' do
        staff_member = build(:staff_member, password: @password, end_date: nil)
        expect(is_authenticated(staff_member, @password)).to be true
      end
    end

    context 'when false' do
      it 'returns false when incorrect password' do
        another_pass = Faker::Internet.password
        staff_member = build(:staff_member, password: @password)
        expect(is_authenticated(staff_member, another_pass)).to be false
      end

      it 'returns false when suspended is true' do
        staff_member = build(:staff_member, password: @password, suspended: true)
        expect(is_authenticated(staff_member, @password)).to be false
      end

      it 'returns false when start_date is after today' do
        staff_member = build(:staff_member, password: @password, start_date: Date.tomorrow)
        expect(is_authenticated(staff_member, @password)).to be false
      end

      it 'returns false when end_date is before today' do
        staff_member = build(:staff_member, password: @password, end_date: Date.yesterday)
        expect(is_authenticated(staff_member, @password)).to be false
      end
    end
  end
end
