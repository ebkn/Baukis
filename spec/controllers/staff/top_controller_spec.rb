require 'rails_helper'

RSpec.describe Staff::TopController, type: :controller do
  let(:staff_member) { create(:staff_member) }

  describe 'restrict by ip addresses' do
    before { Rails.application.config.baukis[:restrict_ip_addresses] = true }

    it 'allows to access' do
      AllowedSource.create!(namespace: 'staff', ip_address: '0.0.0.0')
      get :index
      expect(response).to render_template 'staff/top/index'
    end

    it 'rejects to access' do
      AllowedSource.create!(namespace: 'staff', ip_address: '192.168.0.*')
      get :index
      expect(response).to render_template 'errors/forbidden'
    end
  end
end
