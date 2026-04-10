FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    role {"user"}
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.cell_phone}



  end
end
