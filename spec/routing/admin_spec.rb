require 'rails_helper'

describe 'routing', type: :routing do
  include RSpec::Rails::RequestExampleGroup

  describe 'admin namespace' do
    let(:host) { 'baukis.example.com' }
    let(:url) { "http://#{host}/admin" }

    context 'when sessions controller' do
      let(:path) { "#{url}/session" }
      let(:controller) { 'admin/sessions' }

      it 'routes to #new' do
        expect(get: "#{url}/login").to route_to(
          host: host,
          controller: controller,
          action: 'new'
        )
      end

      it 'redirects to #new' do
        get "#{url}/session"
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

    context 'when staff_members controller' do
      let(:path) { "#{url}/staff_members" }
      let(:controller) { 'admin/staff_members' }

      before { @number = Faker::Number.number }

      it 'routes to #index' do
        expect(get: path).to route_to(
          host: host,
          controller: controller,
          action: 'index'
        )
      end

      it 'routes to #new' do
        expect(get: "#{path}/new").to route_to(
          host: host,
          controller: controller,
          action: 'new'
        )
      end

      it 'routes to #create' do
        expect(post: path).to route_to(
          host: host,
          controller: controller,
          action: 'create'
        )
      end

      it 'routes to #edit' do
        expect(get: "#{path}/#{@number}/edit").to route_to(
          host: host,
          controller: controller,
          action: 'edit',
          id: @number
        )
      end

      it 'routes to #update' do
        expect(patch: "#{path}/#{@number}").to route_to(
          host: host,
          controller: controller,
          action: 'update',
          id: @number
        )
      end

      it 'routes to #show' do
        expect(get: "#{path}/#{@number}").to route_to(
          host: host,
          controller: controller,
          action: 'show',
          id: @number
        )
      end

      it 'routes to #destroy' do
        expect(delete: "#{path}/#{@number}").to route_to(
          host: host,
          controller: controller,
          action: 'destroy',
          id: @number
        )
      end
    end

    context 'when top controller' do
      it 'routes to #index' do
        expect(get: url).to route_to(
          host: host,
          controller: 'admin/top',
          action: 'index'
        )
      end
    end
  end
end
