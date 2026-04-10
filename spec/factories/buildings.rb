FactoryBot.define do
  factory :building do
    name {Faker::Name.name}

    contact_email {Faker::Internet.email}
    contact_phone {Faker::PhoneNumber.cell_phone}
    street {Faker::Address.street_address}
    city {Faker::Address.city}
    building_date {Date.today}
    association :user, factory: :user
    zip_code {Faker::Address.zip_code}

    
  end
end
