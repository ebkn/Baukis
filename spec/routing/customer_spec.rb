require 'rails_helper'

describe 'routing', type: :routing do
  describe 'customer namespace' do
    let(:host) { 'example.com' }
    let(:url) { "http://#{host}/mypage" }

    context 'when top controller' do
      it 'routes to #index' do
        expect(get: url).to route_to(
          host: host,
          controller: 'customer/top',
          action: 'index'
        )
      end
    end
  end
end
