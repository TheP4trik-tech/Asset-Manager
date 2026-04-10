require 'rails_helper'

RSpec.describe Attachment, type: :model do
  subject { create :attachment }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end


  it "is not valid without an asset" do
    subject.asset = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with invalid description" do

    subject.description = "a" * 290
    expect(subject).not_to be_valid
  end

  it "has valid date" do
    subject.added_date = Date.yesterday
    expect(subject).to be_valid
  end

  it "has invalid date" do
    subject.added_date = Date.today + 1
    expect(subject).not_to be_valid
    end
  end

