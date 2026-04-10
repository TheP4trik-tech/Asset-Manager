# spec/models/asset_spec.rb
require 'rails_helper'
RSpec.describe Asset, type: :model do
  subject { create :asset }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a room" do
    subject.room = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with future purchase_date" do
    subject.purchase_date = Date.today + 1
    expect(subject).not_to be_valid
  end

  it "is not valid with negative price" do
    subject.purchase_price = -1
    expect(subject).not_to be_valid
  end

  it "has many attachments" do
    expect(Asset.reflect_on_association(:attachments).macro).to eq(:has_many)
  end
end