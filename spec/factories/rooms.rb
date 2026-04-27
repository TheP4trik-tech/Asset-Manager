FactoryBot.define do
  factory :room do
    name {Faker::Name.name.first(10)}
    room_date {Date.today}
    association :building, factory: :building


  end
end
