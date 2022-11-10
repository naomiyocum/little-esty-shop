require 'rails_helper'

RSpec.describe 'merchant dashboard show page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}
  
  let!(:timmy) {Customer.create!(first_name: "Timmy", last_name: "Limmy")}
  let!(:sue) {Customer.create!(first_name: "Sue", last_name: "Maybis")}
  let!(:shooter) {Customer.create!(first_name: "Shooter", last_name: "Mcgavin")}
  let!(:louise) {Customer.create!(first_name: "Louise", last_name: "Banks")}
  let!(:alfred) {Customer.create!(first_name: "Alfred", last_name: "Borden")}
  let!(:olivia) {Customer.create!(first_name: "Olivia", last_name: "Wenscombe")}
  
  let!(:item_1) {nomi.items.create!(name: "Book", description: "book", unit_price: 11)}
  let!(:item_2) {nomi.items.create!(name: "Big Book", description: "bigger book", unit_price: 11)}
  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  let!(:water) {tyty.items.create!(name: "The Best Water Ever", description: "from the great Cherry Creek Reservoir", unit_price: 100)}
  let!(:shirt) {tyty.items.create!(name: "Funny Shirt", description: "nice", unit_price: 1099)}
  let!(:pants) {tyty.items.create!(name: "Pants", description: "nice", unit_price: 2010)}
  
  let!(:invoice_1) {Invoice.create!(status: 2, customer_id: timmy.id)}
  let!(:invoice_2) {Invoice.create!(status: 2, customer_id: timmy.id)}
  let!(:invoice_3) {Invoice.create!(status: 2, customer_id: sue.id)}
  let!(:invoice_4) {Invoice.create!(status: 2, customer_id: sue.id)}
  let!(:invoice_5) {Invoice.create!(status: 2, customer_id: shooter.id)}
  let!(:invoice_6) {Invoice.create!(status: 2, customer_id: shooter.id)}
  let!(:invoice_7) {Invoice.create!(status: 2, customer_id: louise.id)}
  let!(:invoice_8) {Invoice.create!(status: 2, customer_id: louise.id)}
  let!(:invoice_9) {Invoice.create!(status: 2, customer_id: alfred.id)}
  let!(:invoice_10) {Invoice.create!(status: 2, customer_id: alfred.id)}
  let!(:invoice_11) {Invoice.create!(status: 2, customer_id: olivia.id)}
  let!(:invoice_12) {Invoice.create!(status: 2, customer_id: olivia.id)}
  let!(:invoice_13) {Invoice.create!(status: 2, customer_id: shooter.id)}
  
  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_3.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_9.id, quantity: 2, unit_price: 11, status: "packaged")}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_11.id, quantity: 2, unit_price: 11, status: "pending")}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_13.id, quantity: 1, unit_price: 11, status: "pending")}
  
  let!(:transaction_1) {Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: invoice_1.id)}
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
  let!(:transaction_12) {Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "failed", invoice_id: invoice_12.id)}
  let!(:transaction_13) {Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: invoice_13.id)}
  
  describe 'visit merchant dashboard' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(nomi)

      expect(page).to have_content(nomi.name)
    end

    it 'has a link to merchant items index' do
      visit merchant_dashboard_index_path(nomi)

      click_on("My Items") 
      
      expect(page).to have_current_path("/merchants/#{nomi.id}/items")
    end

    it 'has a link to my merchant invoices index' do
      visit merchant_dashboard_index_path(nomi)

      click_on("My Invoices") 
      
      expect(page).to have_current_path("/merchants/#{nomi.id}/invoices")
    end
    
    describe 'I see the names of the top 5 customers' do
      it 'shows each customer name and the number of successful transactions they have' do
        visit merchant_dashboard_index_path(nomi)

        expect(page).to have_content("Favorite Customers")
        
        within ("#favorite_customers") do
          expect(page).to have_content("#{timmy.first_name} #{timmy.last_name} - 2 Purchases")
          expect(page).to have_content("#{sue.first_name} #{sue.last_name} - 2 Purchases")
          expect(page).to have_content("#{louise.first_name} #{louise.last_name} - 2 Purchases")
          expect(page).to have_content("#{alfred.first_name} #{alfred.last_name} - 2 Purchases")
        end
      end
    end

    it "I see a section for 'Items Ready to Ship'" do
      visit merchant_dashboard_index_path(nomi)
      
      within ("#items_ready_to_ship") do
        expect(page).to have_content("Items Ready to Ship")
      end
    end

    it 'shows a list of item names that have been ordered but not yet shipped' do
      visit merchant_dashboard_index_path(nomi)
  
      within ("#items_ready_to_ship") do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(lamp.name)
        expect(page).to have_content(orion.name)
        expect(page).to have_content(stickers.name)
        expect(page).to_not have_content(pants.name)
      end
    end
    
    it "next to each Item I see the id of the invoice that orderd my item" do
      visit merchant_dashboard_index_path(nomi)
  
      within ("#items_ready_to_ship") do
        
        expect(page).to have_content("#{item_1.name} Invoice##{invoice_1.id}")
        expect(page).to have_content("#{item_1.name} Invoice##{invoice_7.id}")
        expect(page).to have_content("#{lamp.name} Invoice##{invoice_3.id}")
        expect(page).to have_content("#{orion.name} Invoice##{invoice_5.id}")
        expect(page).to have_content("#{stickers.name} Invoice##{invoice_9.id}")
        expect(page).to_not have_content("#{item_1.name} Invoice##{invoice_2.id}")
      end
    end

    it "each invoice id is a link to my merchant's invoice show page" do
      visit merchant_dashboard_index_path(nomi)

      within ("#items_ready_to_ship") do
        
        expect(page).to have_link("#{invoice_1.id}")
        expect(page).to have_link("#{invoice_3.id}")
        expect(page).to have_link("#{invoice_5.id}")
        expect(page).to have_link("#{invoice_7.id}")
        expect(page).to have_link("#{invoice_9.id}")
      end
    end

    it "links go to merchants invoice show page" do
      visit merchant_dashboard_index_path(nomi)
  
      click_link "#{invoice_1.id}"
      
      expect(current_path).to eq("/merchants/#{nomi.id}/invoices/#{invoice_1.id}")
    end

    it 'shows the date next to invoice numbers of a particular invoice' do
        invoice_1.update!(created_at: '2022-08-01')
        invoice_3.update!(created_at: '2022-06-01')
        invoice_5.update!(created_at: '2022-11-01')
        invoice_7.update!(created_at: '2022-02-01')
        invoice_9.update!(created_at: '2022-12-01')
      visit merchant_dashboard_index_path(nomi)

      within ("#items_ready_to_ship") do
        expect(page).to have_content("August 01,2022")
        expect(page).to have_content("February 01,2022")
        expect(page).to have_content("June 01,2022")
        expect(page).to have_content("November 01,2022")
        expect(page).to have_content("December 01,2022")
        expect(page).to_not have_content("August 01,2019")
      end
    end

    describe 'bulk discounts link' do
      it 'includes a link to bulk discounts' do
        visit merchant_dashboard_index_path(nomi)

        click_link 'My Bulk Discounts'

        expect(current_path).to eq(merchant_bulk_discounts_path(nomi))
      end
    end
  end
end