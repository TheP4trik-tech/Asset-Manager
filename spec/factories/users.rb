FactoryBot.define do
  factory :user do

    first_name {Faker::Name.first_name.first(9)}
    last_name {Faker::Name.last_name.first(9)}
    role {"reader"}
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.cell_phone}
    password {Faker::Internet.password}
    password_confirmation {password}




  end
end
