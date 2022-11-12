require 'rails_helper'

RSpec.describe 'Invoice Show Page', type: :feature do
  let!(:merch_1) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 5, percentage_discount: 10)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1, quantity_threshold: 10, percentage_discount: 15)}
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

  describe 'invoice#show' do
    it 'shows invoice id, status, and created at' do
      visit  merchant_invoice_path(merch_1, invoice_1)
    
      expect(page).to have_content(invoice_1.id)

      within ("#info") do
        expect(page).to have_content("Status: #{invoice_1.status}")
        expect(page).to have_content("Created on: Thursday, November 03, 2022")
        expect(page).to have_content("Total Revenue: $#{invoice_1.price_formatter(invoice_1.my_total_revenue)}")
        expect(page).to have_content("Discounted Revenue: $#{invoice_1.price_formatter(invoice_1.discounted_revenue)}")
        expect(page).to have_content("#{customer_1.first_name} #{customer_1.last_name}")
      end
    end

    it 'I see all of my items on the invoice' do
      visit  merchant_invoice_path(merch_1, invoice_1)

      expect(page).to have_content("Items on this Invoice:")
      within ("#items_on_this_invoice") do
        expect(page).to have_content("#{invoice_item_1.item.name}")
        expect(page).to have_content("#{invoice_item_1.quantity}")
        expect(page).to have_content("#{invoice_item_1.item.current_price}")
        expect(page).to have_content("#{invoice_item_1.status}")
      end
    end

    it 'shows a link to the show page for the bulk discount applied to the specific invoice item' do
      visit  merchant_invoice_path(merch_1, invoice_1)

      within ("#items_on_this_invoice") do
        expect(page).to have_content('Bulk Discount')
      end
      
      within ("#invoice-item-#{invoice_item_1.id}") do
        click_on bulk_2.id.to_s
        expect(current_path).to eq(merchant_bulk_discount_path(merch_1, bulk_2))
      end
    end

    it 'I see that each invoice item status is a select field with the current status selected' do
      visit merchant_invoice_path(merch_1, invoice_1)
      
      within ("#invoice-item-#{invoice_item_2.id}") do
        expect(page).to have_field(:status, with: "#{invoice_item_2.status}")
      end
    end

    it 'after clicking update button, I am taken back to the merchant invoice show page and see the status updated' do
      visit merchant_invoice_path(merch_1, invoice_1)

      within("#invoice-item-#{invoice_item_1.id}") do
        expect(invoice_item_1.status).to eq('pending')

        select 'packaged', from: :status
        click_button 'Update Item Status'
      end

      expect(current_path).to eq(merchant_invoice_path(merch_1, invoice_1))
      expect(invoice_item_1.reload.status).to eq('packaged')
    end
  end
end