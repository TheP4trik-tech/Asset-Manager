# spec/requests/api/v1/audit_logs_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::AuditLogs", type: :request do
  let(:user) { create(:user)}
  let(:building) { create(:building, user: user) }
  let(:room) { create(:room, building: building) }
  let(:asset) { create(:asset, room: room) }
  let(:headers) { { 'Authorization' => "Bearer #{user.api_key}" } }
  let!(:audit_log) { create(:audit_log, user: user, auditable: building) }

  describe "GET /api/v1/assets/asset_id/audit_logs" do
    it "returns all audit logs" do
      get "/api/v1/assets/#{asset.id}/audit_logs", headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to be_an(Array)
    end

    it "returns unauthorized without api key" do
      get "/api/v1/assets/#{asset.id}/audit_logs"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end