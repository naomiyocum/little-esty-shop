require 'rails_helper'

RSpec.describe "invoice index page", type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:luffy) {Customer.create!(first_name: "Monkey", last_name: "Luffy")}
  let!(:nami) {Customer.create!(first_name: "Nami", last_name: "Waves")}
  let!(:sanji) {Customer.create!(first_name: "Sanji", last_name: "Foot")}
  let!(:zoro) {Customer.create!(first_name: "Zoro", last_name: "Sword")}

  let!(:invoice_1) {luffy.invoices.create!(status: 2)}
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

  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 2999, status: "shipped")}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 2999, status: "shipped")}
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

  let!(:transaction_1)  {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_1.id)}
  let!(:transaction_2) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_2.id)}
  let!(:transaction_3) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_3.id)}
  let!(:transaction_4) {Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: invoice_4.id)}
  let!(:transaction_5) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_5.id)}
  let!(:transaction_6) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_6.id)}
  let!(:transaction_7) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_7.id)}
  let!(:transaction_8) {Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_8.id)}
  let!(:transaction_9) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_9.id)}
  let!(:transaction_10) {Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_10.id)}
  let!(:transaction_11) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_11.id)}
  let!(:transaction_12) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_12.id)}

  describe "invoices#index" do
    it "should show all invoices id's that include at least one of my merchant's items" do
      visit merchant_invoices_path(nomi)

      expect(page).to have_content("Invoice ##{invoice_1.id}")
      expect(page).to have_content("Invoice ##{invoice_3.id}") 
      expect(page).to have_content("Invoice ##{invoice_5.id}") 
      expect(page).to have_content("Invoice ##{invoice_7.id}") 
      expect(page).to have_content("Invoice ##{invoice_9.id}") 
      expect(page).to have_content("Invoice ##{invoice_11.id}")  
    end
    it 'should have a link to each invoices show page' do
      visit merchant_invoices_path(nomi)

      click_on invoice_1.id.to_s
      expect(current_path).to eq(merchant_invoice_path(nomi, invoice_1))
    end
  end
end