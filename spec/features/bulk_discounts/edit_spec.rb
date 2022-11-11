require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page', type: :feature do
   let!(:merch_1) {create(:merchant)}
  let!(:merch_2) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_2)}

  describe 'bulk_discount#edit' do
    it 'has a form pre-populated with the discounts current attributes' do
      visit edit_merchant_bulk_discount_path(merch_1, bulk_1)

      expect(page).to have_field(:percentage_discount, with: "#{bulk_1.percentage_discount}")
      expect(page).to have_field(:quantity_threshold, with: "#{bulk_1.quantity_threshold}")
    end

    it 'redirects me to the discount show page where I can see the updated info after submitting' do
      visit edit_merchant_bulk_discount_path(merch_1, bulk_1)

      fill_in :percentage_discount, with: 25
      fill_in :quantity_threshold, with: 30
      click_button 'Update Discount'
      
      expect(page).to have_content("Successfully Updated Bulk Discount ##{bulk_1.id}")
      expect(current_path).to eq(merchant_bulk_discount_path(merch_1, bulk_1))

      within("#percentage") do
        expect(page).to have_content("25%")
      end

      within("#quantity") do
        expect(page).to have_content("30")
      end
    end

    it 'gives me an error message if I update with invalid info' do
      visit edit_merchant_bulk_discount_path(merch_1, bulk_1)

      fill_in :percentage_discount, with: 25
      fill_in :quantity_threshold, with: ' '
      click_button 'Update Discount'

      expect(current_path).to eq(edit_merchant_bulk_discount_path(merch_1, bulk_1))
      expect(page).to have_content("Quantity threshold can't be blank")
    end
  end
end