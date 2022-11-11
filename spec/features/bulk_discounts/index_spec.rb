require 'rails_helper'
require 'faker'

RSpec.describe 'The Bulk Discounts Index Page', type: :feature do
   let!(:merch_1) {create(:merchant)}
  let!(:merch_2) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_2)}
  
  describe 'bulk_discounts#index' do
    it 'shows all of the merchants bulk discounts, including percentage and quantity thresholds' do
      visit merchant_bulk_discounts_path(merch_1)

      within("#bulk-discounts-#{bulk_1.id}") do
        expect(page).to have_content(bulk_1.id)
        expect(page).to have_content("Percentage Discount: #{bulk_1.percentage_discount}%")
        expect(page).to have_content("Quantity Threshold: #{bulk_1.quantity_threshold}")
      end

      within("#bulk-discounts-#{bulk_2.id}") do
        expect(page).to have_content(bulk_2.id)
        expect(page).to have_content("Percentage Discount: #{bulk_2.percentage_discount}%")
        expect(page).to have_content("Quantity Threshold: #{bulk_2.quantity_threshold}")
      end
    
      expect(page).to_not have_content(bulk_3.id)
    end

    it 'each bulk discount listed includes a link to its show page' do
      visit merchant_bulk_discounts_path(merch_1)
     
      within("#bulk-discounts-#{bulk_1.id}") do
        click_link bulk_1.id.to_s
      end

      expect(current_path).to eq(merchant_bulk_discount_path(merch_1, bulk_1))
    end

    it 'a link to create a new bulk discount takes me to a new page' do
      visit merchant_bulk_discounts_path(merch_1)

      click_link 'Create New Discount'

      expect(current_path).to eq(new_merchant_bulk_discount_path(merch_1))
    end
  end
end