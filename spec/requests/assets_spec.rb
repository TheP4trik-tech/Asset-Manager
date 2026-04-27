# spec/requests/asset_spec.rb
require 'rails_helper'

RSpec.describe "asset api", type: :request do
  let(:user) { create(:user, api_key: 'test_api_key_123') }
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }
  # Or depending on your auth implementation:
  # let(:headers) { { 'X-Api-Key' => user.api_key } }

  let!(:asset) { create(:asset) }

  describe "return all assets" do
    it "returns success" do
      get "/api/v1/assets", headers: headers
      expect(response).to have_http_status(:success)
    end
  end


end