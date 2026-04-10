
FactoryBot.define do
  factory :audit_log do
    action { "update" }
    auditable { create(:asset) }
    association :user
  end
end