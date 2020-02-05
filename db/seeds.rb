# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

for i in 1..30 do
  Product.create!(
    unique_code: Faker::Alphanumeric.alphanumeric(number: 9, min_alpha: 3, min_numeric: 6),
    description: Faker::Commerce.product_name, 
    detail: Faker::Lorem.paragraph, 
    unit_price: Faker::Commerce.price 
  )
end

for i in 1..30 do
  3.times do 
    Item.create!(
      product_id: i
    )
  end
end

for i in 1..5 do
  User.create!(
    username: Faker::Internet.username(specifier: 5..8), 
    password: 'password'
  )
end

VatCondition.create!(code: 1, description: "IVA Responsable Inscripto")
VatCondition.create!(code: 2, description: "IVA Responsable no Inscripto")
VatCondition.create!(code: 3, description: "IVA no Responsable")
VatCondition.create!(code: 4, description: "IVA Sujeto Exento")
VatCondition.create!(code: 5, description: "Consumidor Final")
VatCondition.create!(code: 6, description: "Responsable Monotributo")
VatCondition.create!(code: 7, description: "Sujeto no Categorizado")
VatCondition.create!(code: 8, description: "Proveedor del Exterior")
VatCondition.create!(code: 9, description: "Cliente del Exterior")
VatCondition.create!(code: 10, description: "IVA Liberado – Ley Nº 19.640")
VatCondition.create!(code: 11, description: "IVA Responsable Inscripto – Agente de Percepción")
VatCondition.create!(code: 12, description: "Pequeño Contribuyente Eventual")
VatCondition.create!(code: 13, description: "Monotributista Social")
VatCondition.create!(code: 14, description: "Pequeño Contribuyente Eventual Social")

for i in 1..5 do
  Client.create!(
    cuil_cuit: Faker::Number.number(digits: 11), 
    email: Faker::Internet.email, 
    name: Faker::Name.name, 
    vat_condition_id: Faker::Number.within(range: 1..14)
  )
end

for i in 1..5 do
    ContactPhone.create!(
      phone: Faker::Number.number(digits: 10), 
      client_id: i
    )
end

for i in 1..5 do
  Reservation.create!(
    client_id: Faker::Number.within(range: 1..5),
    user_id: Faker::Number.within(range: 1..5),
  )
end

# create reservation_details
for i in 1..5 do
  Reservation.find(i).reserve_items([ { product_id: Product.find(i).id, quantity: '1' }, { product_id: Product.find(i+1).id, quantity: '1' } ])
end

# create sells with reservations
for i in 1..3 do
  sell = Reservation.find(i).create_sell
  Reservation.find(i).mark_as_sold(sell.id)
  Reservation.find(i).sell_items(sell.id)
end


# for i in 1..25 do
#   ReservationDetail.create!(
#     item_id: Faker::Number.within(range: 1..120),
#     reservation_id: Faker::Number.within(range: 1..5),
#     price: Faker::Commerce.price
#   )
# end

# sells without assigned reservations
for i in 1..3 do
  Sell.create!(
    client_id: Faker::Number.within(range: 1..5),
    user_id: Faker::Number.within(range: 1..5),
  )
end


for i in 1..3 do
  Sell.find(i).sell_items([ { product_id: Product.find(i*2).id, quantity: '1' }, { product_id: Product.find(i*3).id, quantity: '1' } ])
end

# for i in 1..12 do
#   SellDetail.create!(
#     item_id: Faker::Number.within(range: 1..120),
#     sell_id: Faker::Number.within(range: 1..3),
#     price: Faker::Commerce.price
#   )
# end
