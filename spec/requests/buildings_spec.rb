# spec/requests/api/v1/buildings_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Buildings", type: :request do
  let(:user) { create(:user)}
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }
  let!(:building) { create(:building, user: user) }

  describe "GET /api/v1/buildings" do
    it "returns all buildings" do
      get "/api/v1/buildings", headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to be_an(Array)
    end

    it "returns unauthorized without api key" do
      get "/api/v1/buildings"
      expect(response).to have_http_status(:unauthorized)
    end
  end


  end
