# spec/requests/asset_spec.rb
require 'rails_helper'

RSpec.describe "asset api", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }

  let!(:asset) { create(:asset) }

  describe "return all assets" do
    it "returns success" do
      get "/api/v1/assets", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  it "returns unauthorized without api key" do
    get "/api/v1/assets"
    expect(response).to have_http_status(:unauthorized)
  end
end
