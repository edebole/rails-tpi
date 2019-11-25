# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

for i in 1..30 do
	Product.create(
		unique_code: Faker::Alphanumeric.alphanumeric(number: 9, min_alpha: 3, min_numeric: 6),
		description: Faker::Commerce.product_name, 
		detail: Faker::Lorem.paragraph, 
		unit_price: Faker::Commerce.price )
end

for i in 1..120 do
	Item.create(
		state: "Disponible", 
		product_id: Faker::Number.within(range: 1..30))
end

for i in 1..5 do
	Client.create(cuil_cuit: Faker::Number.number(digits: 10), email: Faker::Internet.email, name: Faker::Name.name, vat_condition_id: Faker::Number.within(range: 1..14))
end

for i in 1..5 do
	ContactPhone.create(phone: Faker::PhoneNumber.cell_phone, client_id: i)
end

VatCondition.create(code: 1, description: "IVA Responsable Inscripto")
VatCondition.create(code: 2, description: "IVA Responsable no Inscripto")
VatCondition.create(code: 3, description: "IVA no Responsable")
VatCondition.create(code: 4, description: "IVA Sujeto Exento")
VatCondition.create(code: 5, description: "Consumidor Final")
VatCondition.create(code: 6, description: "Responsable Monotributo")
VatCondition.create(code: 7, description: "Sujeto no Categorizado")
VatCondition.create(code: 8, description: "Proveedor del Exterior")
VatCondition.create(code: 9, description: "Cliente del Exterior")
VatCondition.create(code: 10, description: "IVA Liberado – Ley Nº 19.640")
VatCondition.create(code: 11, description: "IVA Responsable Inscripto – Agente de Percepción")
VatCondition.create(code: 12, description: "Pequeño Contribuyente Eventual")
VatCondition.create(code: 13, description: "Monotributista Social")
VatCondition.create(code: 14, description: "Pequeño Contribuyente Eventual Social")
