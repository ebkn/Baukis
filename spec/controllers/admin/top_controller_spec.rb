require 'rails_helper'

RSpec.describe Admin::TopController, type: :controller do
  let(:adminstrator) { create(:administrator) }

  describe 'restrice by ip addresses' do
    before { Rails.application.config.baukis[:restrict_ip_addresses] = true }

    it 'allowes to access' do
      AllowedSource.create!(namespace: 'admin', ip_address: '0.0.0.0')
      get :index
      expect(response).to render_template 'admin/top/index'
    end

    it 'rejects to access' do
      AllowedSource.create!(namespace: 'admin', ip_address: '192.168.0.*')
      get :index
      expect(response).to render_template 'errors/forbidden'
    end
  end
end
