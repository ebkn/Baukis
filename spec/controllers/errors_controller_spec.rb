require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  describe "GET #routing_error" do
    it "returns http success" do
      get :routing_error
      expect(response).to have_http_status(:success)
    end
  end

end
