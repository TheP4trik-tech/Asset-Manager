FactoryBot.define do
  factory :building do
    name {Faker::Name.name.first(9)}

    contact_email {Faker::Internet.email}
    contact_phone {Faker::PhoneNumber.cell_phone}
    street {Faker::Address.street_address.first(15)}
    city {Faker::Address.city.first(9)}
    building_date {Date.today}
    association :user, factory: :user
    zip_code {Faker::Address.zip_code}

    
  end
end
