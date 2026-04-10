require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    subject { create :user }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end
    it "raises error with invalid role" do
      expect { subject.role = "bad_role" }.to raise_error(ArgumentError)
    end
    it "is not valid without a role" do
      subject.role = nil
      expect(subject).to_not be_valid
    end
    it "has a generated code" do
      expect(subject.code).to be_present
    end

    it "has a unique code" do
      user2 = create(:user)
      expect(subject.code).not_to eq(user2.code)
    end

    it "has a generated api_key" do
      expect(subject.api_key).to be_present
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it "is not valid with invalid email" do
      subject.email = "invalid"
      expect(subject).not_to be_valid
    end


  end
end

