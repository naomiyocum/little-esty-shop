require 'rails_helper'

RSpec.describe 'The Bulk Discounts Index Page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:bulk_1) {nomi.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
  let!(:bulk_2) {nomi.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 50)}
  let!(:bulk_3) {tyty.bulk_discounts.create!(percentage_discount: 5, quantity_threshold: 3)}
  
  describe 'bulk_discounts#index' do
    it 'shows all of the merchants bulk discounts, including percentage and quantity thresholds' do
      visit merchant_bulk_discounts_path(nomi)

      within("#bulk-discounts-#{bulk_1.id}") do
        expect(page).to have_content(bulk_1.id)
        expect(page).to have_content("Percentage Discount: #{bulk_1.percentage_discount}")
        expect(page).to have_content("Quantity Threshold: #{bulk_1.quantity_threshold}")
      end

      within("#bulk-discounts-#{bulk_2.id}") do
        expect(page).to have_content(bulk_2.id)
        expect(page).to have_content("Percentage Discount: #{bulk_2.percentage_discount}")
        expect(page).to have_content("Quantity Threshold: #{bulk_2.quantity_threshold}")
      end
    
      expect(page).to_not have_content(bulk_3.id)
    end

    it 'each bulk discount listed includes a link to its show page' do
      visit merchant_bulk_discounts_path(nomi)
     
      within("#bulk-discounts-#{bulk_1.id}") do
        click_link bulk_1.id.to_s
      end

      expect(current_path).to eq(merchant_bulk_discount_path(nomi, bulk_1))
    end

    it 'a link to create a new bulk discount takes me to a new page' do
      visit merchant_bulk_discounts_path(nomi)

      click_link 'Create New Discount'

      expect(current_path).to eq(new_merchant_bulk_discount_path(nomi))
    end
  end
end