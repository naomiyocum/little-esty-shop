require 'rails_helper'

RSpec.describe 'Invoice Show Page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:luffy) {Customer.create!(first_name: "Monkey", last_name: "Luffy")}
  let!(:nami) {Customer.create!(first_name: "Nami", last_name: "Waves")}
  let!(:sanji) {Customer.create!(first_name: "Sanji", last_name: "Foot")}
  let!(:zoro) {Customer.create!(first_name: "Zoro", last_name: "Sword")}

  let!(:invoice_1) {luffy.invoices.create!(status: 2, created_at: Time.parse("22.11.03"))}
  let!(:invoice_2) {luffy.invoices.create!(status: 2)}
  let!(:invoice_3) {luffy.invoices.create!(status: 2)}
  let!(:invoice_4) {nami.invoices.create!(status: 2)}
  let!(:invoice_5) {nami.invoices.create!(status: 2)}
  let!(:invoice_6) {sanji.invoices.create!(status: 2)}
  let!(:invoice_7) {sanji.invoices.create!(status: 2)}
  let!(:invoice_8) {sanji.invoices.create!(status: 2)}
  let!(:invoice_9) {sanji.invoices.create!(status: 2)}
  let!(:invoice_10) {zoro.invoices.create!(status: 2)}
  let!(:invoice_11) {zoro.invoices.create!(status: 2)}
  let!(:invoice_12) {zoro.invoices.create!(status: 2)}

  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 300, status: "pending")}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_3.id, quantity: 10, unit_price: 300, status: "shipped")}
  let!(:invoice_item_3)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 2999, status: "shipped")}
  let!(:invoice_item_4)  {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_7.id, quantity: 5, unit_price: 100, status: "shipped")}
  let!(:invoice_item_5)  {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_9.id, quantity: 1, unit_price: 100, status: "shipped")}
  let!(:invoice_item_6)  {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_11.id, quantity: 1, unit_price: 1000, status: "shipped")}
  let!(:invoice_item_7)  {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_11.id, quantity: 1, unit_price: 1000, status: "shipped")}
  let!(:invoice_item_8)  {InvoiceItem.create!(item_id: oil.id, invoice_id: invoice_11.id, quantity: 10, unit_price: 2599, status: "shipped")}
  let!(:invoice_item_9)  {InvoiceItem.create!(item_id: pants.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 2100, status: "shipped")}
  

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  let!(:water) {tyty.items.create!(name: "The Best Water Ever", description: "from the great Cherry Creek Reservoir", unit_price: 100)}
  let!(:shirt) {tyty.items.create!(name: "Funny Shirt", description: "nice", unit_price: 1099)}
  let!(:pants) {tyty.items.create!(name: "Pants", description: "nice", unit_price: 2010)}

  let!(:discount_10off) {BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: nomi.id)}
  let!(:discount_20off)  {BulkDiscount.create!(name: "20 off for 10 items", threshold: 10, percentage_discount: 20, merchant_id: nomi.id)}
  let!(:discount_30off)  {BulkDiscount.create!(name: "30 off for 11 items", threshold: 11, percentage_discount: 30, merchant_id: nomi.id)}
  describe 'invoice#show' do
    it 'shows invoice id, status, and created at' do
      visit  merchant_invoice_path(nomi, invoice_1)
     
      expect(page).to have_content(invoice_1.id)

      within ("#info") do
        expect(page).to have_content("Status: #{invoice_1.status}")
        expect(page).to have_content("Created on: Thursday, November 03, 2022")
        expect(page).to have_content("Total Revenue: $30.00")
        expect(page).to have_content("#{luffy.first_name} #{luffy.last_name}")
      end
    end

    it 'I see all of my items on the invoice' do
      visit  merchant_invoice_path(nomi, invoice_1)

      expect(page).to have_content("Items on this Invoice:")
      within ("#items_on_this_invoice") do
        expect(page).to have_content("#{invoice_item_1.item.name}")
        expect(page).to have_content("#{invoice_item_1.quantity}")
        expect(page).to have_content("#{invoice_item_1.item.current_price}")
        expect(page).to have_content("#{invoice_item_1.status}")
        expect(page).to_not have_content("#{invoice_item_8.item.name}")
        expect(page).to_not have_content("#{invoice_item_9.item.name}")
      end
    end

    it 'I see that each invoice item status is a select field with the current status selected' do
      visit merchant_invoice_path(nomi, invoice_2)
      
      within ("#items_on_this_invoice") do
        expect(page).to have_field(:status, with: "#{invoice_item_2.status}")
      end
    end

    it 'after clicking update button, I am taken back to the merchant invoice show page and see the status updated' do
      visit merchant_invoice_path(nomi, invoice_1)

      within("#update_status") do
        expect(invoice_item_1.status).to eq('pending')

        select 'packaged', from: :status
        click_button 'Update Item Status'
      end

      expect(current_path).to eq(merchant_invoice_path(nomi, invoice_1))
      expect(invoice_item_1.reload.status).to eq('packaged')
    end

    it 'shows the total revenue discounted' do
      visit merchant_invoice_path(nomi, invoice_3)

      within("#info") do
        expect(page).to have_content("Total Discounted Revenue: $24.00")
      end
    end

    it 'shows the discount next to an invoice item' do
      visit merchant_invoice_path(nomi, invoice_3)

      within("#items_on_this_invoice") do
        expect(page).to have_link(discount_20off.name)
      end
    end

    it 'each discount link will take you to its individual show page' do
      visit merchant_invoice_path(nomi, invoice_3)
      within("#items_on_this_invoice") do
        click_on "#{discount_20off.name}"
        
        expect(page).to have_current_path(merchant_bulk_discount_path(nomi, discount_20off))
      end
    end

    it 'should not have a link' do
      # require 'pry'; binding.pry
      visit merchant_invoice_path(nomi, invoice_9)
      within("#items_on_this_invoice") do
        
        expect(page).to_not have_content(discount_20off.name)
      end
    end
  end
end