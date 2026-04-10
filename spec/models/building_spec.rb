# spec/models/building_spec.rb
require 'rails_helper'
RSpec.describe Building, type: :model do
  subject { create :building }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end


  it "is not valid without a contact_email" do
    subject.contact_email = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with invalid email" do
    subject.contact_email = "invalid"
    expect(subject).not_to be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with future building_date" do
    subject.building_date = Date.today + 1
    expect(subject).not_to be_valid
  end

  it "has many rooms" do
    expect(Building.reflect_on_association(:rooms).macro).to eq(:has_many)
  end

  it "has a generated code" do
    expect(subject.code).to be_present
  end

  it "has a unique code" do
    building2 = create(:building)
    expect(subject.code).not_to eq(building2.code)
  end

  it "belongs to a user" do
    expect(Building.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it "has many assets through rooms" do
    expect(Building.reflect_on_association(:assets).macro).to eq(:has_many)
  end

  it "is not valid without a building_date" do
    subject.building_date = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a contact_phone" do
    subject.contact_phone = nil
    expect(subject).not_to be_valid
  end
end