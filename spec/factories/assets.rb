FactoryBot.define do
factory :asset do
  name { Faker::Commerce.product_name.first(10) }
  purchase_date { Faker::Date.backward(days: 365) }
  last_check_date { Faker::Date.backward(days: 30) }
  purchase_price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  association :room, factory: :room
end
end