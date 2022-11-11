require 'rails_helper'

RSpec.describe 'Destroy Bulk Discount', type: :feature do
  let!(:merch_1) {create(:merchant)}
  let!(:merch_2) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_2)}

  describe 'deletes bulk discount from merchant index page' do
    it 'each bulk discount has a delete button next to it' do
      visit merchant_bulk_discounts_path(merch_1)
      expect(page).to have_content(bulk_1.id)

      within("#bulk-discounts-#{bulk_1.id}") do
        click_button 'Delete'
      end
      

      expect(current_path).to eq(merchant_bulk_discounts_path(merch_1))
      
      expect(page).to_not have_content("Bulk Discount #{bulk_1.id}")
    end 
  end
end