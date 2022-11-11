require 'rails_helper'

RSpec.describe 'Destroy Bulk Discount', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:bulk_1) {nomi.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
  let!(:bulk_2) {nomi.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 50)}
  let!(:bulk_3) {tyty.bulk_discounts.create!(percentage_discount: 5, quantity_threshold: 3)}

  describe 'deletes bulk discount from merchant index page' do
    it 'each bulk discount has a delete button next to it' do
      visit merchant_bulk_discounts_path(nomi)
      expect(page).to have_content(bulk_1.id)

      within("#bulk-discounts-#{bulk_1.id}") do
        click_button 'Delete'
      end
      

      expect(current_path).to eq(merchant_bulk_discounts_path(nomi))
      
      expect(page).to_not have_content("Bulk Discount #{bulk_1.id}")
    end 
  end
end