require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  subject { create :audit_log }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "belongs to auditable polymorphically" do
    expect(AuditLog.reflect_on_association(:auditable).macro).to eq(:belongs_to)
  end

  it "belongs to a user" do
    expect(AuditLog.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it "is not valid without an auditable" do
    subject.auditable = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).not_to be_valid
  end
end