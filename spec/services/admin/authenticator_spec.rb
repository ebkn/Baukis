require 'spec_helper'

describe Admin::Authenticator do
  describe '#authenticate' do
    def is_authenticated(administrator, password)
      Admin::Authenticator.new(administrator).authenticate(password)
    end

    before(:each) do
      @password = Faker::Internet.password
    end

    context 'when success' do
      it 'returns true when correct password' do
        administrator = build(:administrator, password: @password)
        expect(is_authenticated(administrator, @password)).to be true
      end
    end

    context 'when failed' do
      it 'returns false when incorrect password' do
        another_pass = Faker::Internet.password
        administrator = build(:administrator, password: @password)
        expect(is_authenticated(administrator, another_pass)).to be false
      end

      it 'returns false when suspended is true' do
        administrator = build(:administrator, password: @password, suspended: true)
        expect(is_authenticated(administrator, @password)).to be false
      end
    end
  end
end
