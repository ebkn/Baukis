require 'rails_helper'

RSpec.describe AllowedSource, type: :model do
  describe '.include?' do
    before do
      Rails.application.config.baukis[:restrict_ip_addresses] = true
      AllowedSource.create!(namespace: 'staff', ip_address: '127.0.0.1')
      AllowedSource.create!(namespace: 'staff', ip_address: '192.168.0.*')
    end

    context 'when ip address does not match' do
      it 'returns false' do
        expect(AllowedSource.include?('staff', '192.168.1.1')).to eq false
      end
    end

    context 'when ip address matches' do
      it 'returns true when all octets match' do
        expect(AllowedSource.include?('staff', '127.0.0.1')).to eq true
      end

      it 'returns true when octets including wildcard match' do
        expect(AllowedSource.include?('staff', '192.168.0.100')).to eq true
      end
    end
  end

  describe '#ip_address=' do
    context 'when valid ip address' do
      it 'is valid when ip address is 127.0.0.1' do
        src = AllowedSource.new(namespace: 'staff', ip_address: '127.0.0.1')
        expect(src.octet1).to eq 127
        expect(src.octet2).to eq 0
        expect(src.octet3).to eq 0
        expect(src.octet4).to eq 1
        expect(src).not_to be_wildcard
        expect(src).to be_valid
      end

      it 'is valid when ip address is 192.168.0.*' do
        src = AllowedSource.new(namespace: 'staff', ip_address: '192.168.0.*')
        expect(src.octet1).to eq 192
        expect(src.octet2).to eq 168
        expect(src.octet3).to eq 0
        expect(src.octet4).to eq 0
        expect(src).to be_wildcard
        expect(src).to be_valid
      end
    end

    context 'when invalid ip address' do
      it 'is invalid when ip address is A.B.C.C' do
        src = AllowedSource.new(namespace: 'staff', ip_address: 'A.B.C.D')
        expect(src).not_to be_valid
      end
    end
  end
end
