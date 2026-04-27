# spec/requests/api/v1/rooms_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Rooms", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }
  let(:building) { create(:building, user: user) }
  let!(:room) { create(:room, building: building) }

  describe "GET /api/v1/rooms" do
    it "returns all rooms" do
      get "/api/v1/rooms", headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to be_an(Array)
    end

    it "returns unauthorized without api key" do
      get "/api/v1/rooms"
      expect(response).to have_http_status(:unauthorized)
    end
  end


end