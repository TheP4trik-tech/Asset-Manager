require 'rails_helper'

RSpec.describe "asset api", type: :request do
  let(:asset) { create(:asset) }
  let(:user) { create(:user) }
  it "return all assets" do
    get "/api/v1/assets",headers: { "Authorization" => "Bearer #{user.api_key}"}
    expect(response).to have_http_status(:success)
  end

  it "return 400 without api key" do
    get "/api/v1/assets"
    expect(response).to have_http_status(:unauthorized)
  end

  it "return a single asset" do
    get "/api/v1/assets/#{asset.id}", headers: {"Authorization" => "Bearer #{user.api_key}"}
    expect(response).to have_http_status(:success)
    p
  end
  it "delete an asset" do
    delete "/api/v1/assets/#{asset.id}",headers: { "Authorization" => "Bearer #{user.api_key}"}
    expect(response).to have_http_status(:success)
  end
  it "update an asset" do
    put "/api/v1/assets/#{asset.id}",headers: { "Authorization" => "Bearer #{user.api_key}"}, params: {asset: {name: "new name"}}
    expect(response).to have_http_status(:success)
  end

end
