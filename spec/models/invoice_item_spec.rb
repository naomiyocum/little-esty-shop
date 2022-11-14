require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let!(:nomi)  {Merchant.create!(name: "Naomi LLC")}
  let!(:merchant_1) {Merchant.create!(name: "Shawn LLC")}
  let!(:merchant_2) {Merchant.create!(name: "Naomi LLC")}
  let!(:merchant_3) {Merchant.create!(name: "Kristen LLC")}
  let!(:merchant_4) {Merchant.create!(name: "Yuji LLC")}
  let!(:merchant_5) {Merchant.create!(name: "Turing LLC")}

  let!(:customer_1) {Customer.create!(first_name: "Sally", last_name: "Shopper")}
  let!(:customer_2) {Customer.create!(first_name: "Evan", last_name: "East")}
  let!(:customer_3) {Customer.create!(first_name: "Yasha", last_name: "West")}
  let!(:customer_4) {Customer.create!(first_name: "Du", last_name: "North")}
  let!(:customer_5) {Customer.create!(first_name: "Polly", last_name: "South")}

  let!(:item_1) {Item.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 300, merchant_id: nomi.id)}
  let!(:item_2) {Item.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000, merchant_id: merchant_2.id)}
  let!(:item_3) {Item.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850, merchant_id: merchant_3.id)}

  let!(:invoice_1) {Invoice.create!(status: "in progress", customer_id: customer_1.id)}
  let!(:invoice_2) {Invoice.create!(status: "cancelled", customer_id: customer_2.id)}
  let!(:invoice_3) {Invoice.create!(status: "completed", customer_id: customer_3.id)}
  let!(:invoice_4) {Invoice.create!(status: "in progress", customer_id: customer_4.id)}
  let!(:invoice_5) {Invoice.create!(status: "in progress", customer_id: customer_4.id)}
  let!(:invoice_6) {Invoice.create!(status: "in progress", customer_id: customer_4.id)}

  let!(:invoice_items_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 300, status: "shipped")}
  let!(:invoice_items_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_items_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_items_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_items_5) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_items_6) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_6.id, quantity: 2, unit_price: 11, status: "shipped")}

  let!(:discount_10off)  {BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: nomi.id)}
  let!(:discount_20off)  {BulkDiscount.create!(name: "20 off for 10 items", threshold: 10, percentage_discount: 20, merchant_id: nomi.id)}
  let!(:discount_30off)  {BulkDiscount.create!(name: "30 off for 11 items", threshold: 11, percentage_discount: 30, merchant_id: nomi.id)}
 
  describe 'relationships' do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
    it {should have_many(:bulk_discounts).through(:item)}
  end

  describe 'validations' do
    it {should validate_presence_of(:quantity)}
    it {should validate_numericality_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_numericality_of(:unit_price)}
    it {should validate_presence_of(:status)}
  end

  describe 'model tests' do
    describe '#uniq_invoice_items' do
      it 'returns a unique list of invoice items' do
        expect(InvoiceItem.uniq_invoice_items.count).to eq(6)
      end
    end

    describe 'a#pplied_discount' do
      it 'returns the discount that has been applied to an item' do

        expect(invoice_items_1.applied_discount).to eq(discount_20off)
      end
    end 
  end
end
