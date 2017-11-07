require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe '#password=' do
    it 'creates 60 characters hashed_password' do
      administrator = Administrator.new
      administrator.password = Faker::StarWars.character
      expect(administrator.hashed_password).to be_kind_of(String)
      expect(administrator.hashed_password.size).to eq(60)
    end

    it 'creates nil hashed_password' do
      administrator = Administrator.new
      administrator.password = nil
      expect(administrator.hashed_password).to be_nil
    end
  end
end
