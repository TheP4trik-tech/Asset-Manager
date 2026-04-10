# spec/models/room_spec.rb
require 'rails_helper'
RSpec.describe Room, type: :model do
  subject { create :room }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a building" do
    subject.building = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with future room_date" do
    subject.room_date = Date.today + 1
    expect(subject).not_to be_valid
  end

  it "has many assets" do
    expect(Room.reflect_on_association(:assets).macro).to eq(:has_many)
  end

  it "has a generated code" do
    expect(subject.code).to be_present
  end

  it "has a unique code" do
    room2 = create(:room)
    expect(subject.code).not_to eq(room2.code)
  end

  it "belongs to a building" do
    expect(Room.reflect_on_association(:building).macro).to eq(:belongs_to)
  end

  it "is not valid without a room_date" do
    subject.room_date = nil
    expect(subject).not_to be_valid
  end
end