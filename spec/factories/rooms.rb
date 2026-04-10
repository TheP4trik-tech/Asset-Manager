FactoryBot.define do
  factory :room do
    name {Faker::Name.name}
    room_date {Date.today}
    association :building, factory: :building


  end
end
