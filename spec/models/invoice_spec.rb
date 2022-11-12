require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let!(:merch_1) {create(:merchant)}
  let!(:merch_2) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 5, percentage_discount: 5)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 10, percentage_discount: 10)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 20, percentage_discount: 20)}

  let!(:customer_1) {create(:customer)}
  let!(:customer_2) {create(:customer)}
  let!(:customer_3) {create(:customer)}

  let!(:invoice_1) {customer_1.invoices.create!(status: 2, created_at: Time.parse("22.11.03"))}
  let!(:invoice_2) {create(:invoice, customer: customer_1, status: 2)}
  let!(:invoice_3) {create(:invoice, customer: customer_1, status: 2)}
  let!(:invoice_4) {create(:invoice, customer: customer_2, status: 2)}
  let!(:invoice_5) {create(:invoice, customer: customer_3, status: 2)}
  let!(:invoice_6) {create(:invoice, customer: customer_3, status: 2)}

  let!(:invoice_item_1) {create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 100, status: 0)}
  let!(:invoice_item_2) {create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 5, unit_price: 20, status: 0)}
  let!(:invoice_item_3) {create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 1, unit_price: 35, status: 0)}
  let!(:invoice_item_4) {create(:invoice_item, invoice: invoice_1, item: item_4, quantity: 12, unit_price: 50, status: 0)}

  let!(:item_1) {create(:item, merchant: merch_1)}
  let!(:item_2) {create(:item, merchant: merch_1)}
  let!(:item_3) {create(:item, merchant: merch_1)}
  let!(:item_4) {create(:item, merchant: merch_1)}

  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:transactions)}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'class methods' do
    describe '#uniq_invoices' do
      it 'returns unique invoices' do
        expect(Invoice.uniq_invoices.count).to eq(6)
      end
    end

    describe "incomplete_invoices" do
      it 'should show incomplete invoices' do
        expect(Invoice.incomplete_invoices).to include(invoice_1)
      end
    end
  end

  describe 'instance methods' do
    describe '#my_total_revenue' do
      it 'returns the total revenue for a specific merchant' do
        expect(invoice_1.my_total_revenue).to eq(1735)
      end
    end

    describe '#price_formatter' do
      it 'returns the price formatted correctly' do
        expect(invoice_1.price_formatter(invoice_1.my_total_revenue)).to eq('17.00')
      end
    end

    describe '#qualified_invoice_items' do
      it 'returns the invoice_items that qualify for a discount' do
        expect(invoice_1.qualified_invoice_items.length).to eq(3)
      end
    end

    describe '#all_discounts' do
      it 'returns the sum of discounts applied to the invoice' do
        expect(invoice_1.all_discounts).to eq(165)
      end
    end

    describe '#discounted_revenue' do
      it 'returns the revenue after discounts are applied' do
        expect(invoice_1.discounted_revenue).to eq(1570)
      end
    end
  end
end
