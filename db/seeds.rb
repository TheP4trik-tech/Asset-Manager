# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
 AuditLog.destroy_all
 Asset.destroy_all
 Room.destroy_all
 Building.destroy_all
 User.destroy_all
Faker::Config.locale = "cs"
puts "Seeding database..."
password = "123456"
5.times do
  User.create!(email: Faker::Internet.email,
               phone: Faker::PhoneNumber.cell_phone,
               password: password,
               password_confirmation: password,
               first_name: Faker::Name.first_name.first(10),
               last_name: Faker::Name.last_name.first(10),
               role: "reader")
end

3.times do
   User.create!(email: Faker::Internet.email,
               password: password,
               password_confirmation: password,
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               phone: Faker::PhoneNumber.cell_phone,
               role: "super_admin")
end
puts "Database seeded!"

10.times do
  admin = User.create!(email: Faker::Internet.email,
                       phone: Faker::PhoneNumber.cell_phone,
                       password: password,
                       password_confirmation: password,
                       first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       role: "admin")
  building =  Building.create!(name: Faker::Name.name.first(10),
                   user_id: admin.id,
                   contact_email: Faker::Internet.email.first(20),
                   contact_phone: Faker::PhoneNumber.cell_phone,
                   street: Faker::Address.street_address.first(19),
                   city: Faker::Address.city.first(9),
                   building_date: Date.today,
                   zip_code: Faker::Address.zip_code,
                   )
  room =  Room.create!(
               name: Faker::Name.name.first(10),
               building_id: building.id,
               room_date: Faker::Date.between(from: Date.today, to: Date.today - 30)
               )
  asset = Asset.create!(name: Faker::Commerce.product_name.first(10),
               room_id: room.id,
               purchase_date: Faker::Date.backward(days: 365),
               last_check_date: Faker::Date.backward(days: 30),
               purchase_price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
                        note: Faker::Lorem.sentence(word_count: 10))
  AuditLog.create!(action: "create", auditable: asset, user: admin)
 end