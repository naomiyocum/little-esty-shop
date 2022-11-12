require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let!(:merch_1) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 5, percentage_discount: 5)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 10, percentage_discount: 10)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 20, percentage_discount: 20)}

  let!(:customer_1) {create(:customer)}
  let!(:customer_2) {create(:customer)}
  let!(:customer_3) {create(:customer)}

  let!(:invoice_1) {customer_1.invoices.create!(status: 2, created_at: Time.parse("22.11.03"))}
  let!(:invoice_2) {create(:invoice, customer: customer_1)}

  let!(:invoice_item_1) {create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 100, status: 0)}
  let!(:invoice_item_2) {create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 5, unit_price: 20, status: 0)}
  let!(:invoice_item_3) {create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 1, unit_price: 35, status: 0)}
  let!(:invoice_item_4) {create(:invoice_item, invoice: invoice_1, item: item_4, quantity: 12, unit_price: 50, status: 0)}

  let!(:item_1) {create(:item, merchant: merch_1)}
  let!(:item_2) {create(:item, merchant: merch_1)}
  let!(:item_3) {create(:item, merchant: merch_1)}
  let!(:item_4) {create(:item, merchant: merch_1)}

  describe 'relationships' do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end

  describe 'validations' do
    it {should validate_presence_of(:quantity)}
    it {should validate_numericality_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_numericality_of(:unit_price)}
    it {should validate_presence_of(:status)}
  end

  describe 'class methods' do
    describe '#uniq_invoice_items' do
      it 'returns a unique list of invoice items' do
        expect(InvoiceItem.uniq_invoice_items.count).to eq(4)
      end
    end
  end

  describe 'instance methods' do
    describe '#available_discount' do
      it 'returns the highest discount the invoice_item qualifies for' do
        expect(invoice_item_1.available_discount).to eq(bulk_2)
        expect(invoice_item_3.available_discount).to eq(nil)
      end
    end

    describe '#my_rev' do
      it 'returns the revenue for a specific invoice_item' do
        expect(invoice_item_1.my_revenue).to eq(1000)
        expect(invoice_item_2.my_revenue).to eq(100)
      end
    end

    describe '#discount_calc' do
      it 'returns the dollar amount discount an invoice_item gets' do
        expect(invoice_item_1.discount_calc).to eq(0.1)
        expect(invoice_item_2.discount_calc).to eq(0.05)
      end
    end

    describe '#discount_dollars' do
      it 'returns the new price after discount' do
        expect(invoice_item_1.discount_dollars).to eq(100)
        expect(invoice_item_2.discount_dollars).to eq(5)
      end
    end
  end
end
