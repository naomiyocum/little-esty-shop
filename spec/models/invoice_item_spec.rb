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

  let!(:invoice_item_1) {create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, status: 0)}
  let!(:invoice_item_2) {create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 5)}
  let!(:invoice_item_3) {create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 1)}
  let!(:invoice_item_4) {create(:invoice_item, invoice: invoice_1, item: item_4, quantity: 12)}

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

  describe 'model tests' do
    describe '#uniq_invoice_items' do
      it 'returns a unique list of invoice items' do
        expect(InvoiceItem.uniq_invoice_items.count).to eq(4)
      end
    end

    describe '#max_discount' do
      it 'returns the highest discount the invoice_item qualifies for' do
        expect(invoice_item_1.max_discount). to eq(bulk_2)
      end
    end
  end


end
