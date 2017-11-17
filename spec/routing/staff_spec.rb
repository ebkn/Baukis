require 'rails_helper'

describe 'routing', type: :routing do
  include RSpec::Rails::RequestExampleGroup

  describe 'staff' do
    let(:host) { 'baukis.example.com' }
    let(:url) { "http://#{host}" }

    context 'when sessions controller' do
      let(:path) { "#{url}/session" }
      let(:controller) { 'staff/sessions' }

      it 'routes to #new' do
        expect(get: "#{url}/login").to route_to(
          host: host,
          controller: controller,
          action: 'new'
        )
      end

      it 'redirects to #new' do
        get path
        expect(response).to redirect_to("#{url}/login")
      end

      it 'routes to #create' do
        expect(post: path).to route_to(
          host: host,
          controller: controller,
          action: 'create'
        )
      end

      it 'routes to #destroy' do
        expect(delete: path).to route_to(
          host: host,
          controller: controller,
          action: 'destroy'
        )
      end
    end

    context 'when account controller' do
      let(:path) { "#{url}/account" }
      let(:controller) { 'staff/accounts' }

      it 'routes to #show' do
        expect(get: path).to route_to(
          host: host,
          controller: controller,
          action: 'show'
        )
      end

      it 'routes to #edit' do
        expect(get: "#{path}/edit").to route_to(
          host: host,
          controller: controller,
          action: 'edit'
        )
      end

      it 'routes to #update' do
        expect(patch: path).to route_to(
          host: host,
          controller: controller,
          action: 'update'
        )
      end
    end

    context 'when password controller' do
      let(:path) { "#{url}/password" }
      let(:controller) { 'staff/passwords' }

      it 'routes to #show' do
        expect(get: path).to route_to(
          host: host,
          controller: controller,
          action: 'show'
        )
      end

      it 'routes to #edit' do
        expect(get: "#{path}/edit").to route_to(
          host: host,
          controller: controller,
          action: 'edit'
        )
      end

      it 'routes to #update' do
        expect(patch: path).to route_to(
          host: host,
          controller: controller,
          action: 'update'
        )
      end
    end

    context 'when top controller' do
      it 'routes to #index' do
        expect(get: url).to route_to(
          host: host,
          controller: 'staff/top',
          action: 'index'
        )
      end
    end
  end
end
