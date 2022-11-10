# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@naomi = Merchant.create!(name: "Naomi LLC")
@tyty = Merchant.create!(name: "Tyty's Devil Fruits")
@merchant_5 = Merchant.create!(name: "Turing LLC")

@bulk_1 = @naomi.bulk_discounts.create!(percentage_discount: 20, quantity_thresholds: 10)
@bulk_2 = @naomi.bulk_discounts.create!(percentage_discount: 50, quantity_thresholds: 30)
@bulk_3 = @tyty.bulk_discounts.create!(percentage_discount: 5, quantity_thresholds: 3)

@customer_1 = Customer.create!(first_name: "Sally", last_name: "Shopper")
@customer_2 = Customer.create!(first_name: "Evan", last_name: "East")
@customer_3 = Customer.create!(first_name: "Yasha", last_name: "West")
@customer_4 = Customer.create!(first_name: "Du", last_name: "North")
@customer_5 = Customer.create!(first_name: "Polly", last_name: "South")
@customer_6 = Customer.create!(first_name: "Dolly", last_name: "North")

@item_1 = Item.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500, merchant_id: @merchant_1.id)
@item_2 = Item.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000, merchant_id: @merchant_2.id)
@item_3 = Item.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850, merchant_id: @merchant_3.id)

@invoice_1 = Invoice.create!(status: "in progress", customer_id: @customer_1.id)
@invoice_2 = Invoice.create!(status: "cancelled", customer_id: @customer_1.id)
@invoice_3 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
@invoice_4 = Invoice.create!(status: "in progress", customer_id: @customer_2.id)
@invoice_5 = Invoice.create!(status: "in progress", customer_id: @customer_4.id)
@invoice_6 = Invoice.create!(status: "in progress", customer_id: @customer_2.id)

@invoice_items_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 11, status: "shipped", created_at: Time.parse("22.11.02"))
@invoice_items_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 11, status: "packaged", created_at: Time.parse("22.11.06"))
@invoice_items_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 11, status: "pending", created_at: Time.parse("22.11.04"))
@invoice_items_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 11, status: "packaged", created_at: Time.parse("22.11.08"))
@invoice_items_5 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_5.id, quantity: 2, unit_price: 11, status: "pending", created_at: Time.parse("22.11.03"))
@invoice_items_6 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 11, status: "shipped", created_at: Time.parse("22.11.09"))
