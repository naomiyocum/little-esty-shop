require 'rails_helper'

RSpec.describe 'Bulk Discount New Discount', type: :feature do
   let!(:merch_1) {create(:merchant)}
  let!(:merch_2) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_2)}

  describe 'bulk_discount#create' do
    it 'after submitting the form with valid data, I am redirected back to the index page and see the new discount' do
      visit new_merchant_bulk_discount_path(merch_1)

      fill_in :percentage_discount, with: 34
      fill_in :quantity_threshold, with: 19

      click_button 'Create New Discount'

      new_discount = BulkDiscount.last
      
      expect(page).to have_content("Successfully Created Bulk Discount ##{new_discount.id}")
      expect(current_path).to eq(merchant_bulk_discounts_path(merch_1))

      within "#bulk-discounts-#{new_discount.id}" do
        expect(page).to have_content(new_discount.id)
        expect(page).to have_content("Percentage Discount: #{new_discount.percentage_discount}")
        expect(page).to have_content("Quantity Threshold: #{new_discount.quantity_threshold}")
      end
    end

    it 'returns an error message if fields are not filled correctly' do
      visit new_merchant_bulk_discount_path(merch_1)
      
      fill_in :percentage_discount, with: ' '
      fill_in :quantity_threshold, with: 23

      click_button 'Create New Discount'
      
      expect(current_path).to eq(new_merchant_bulk_discount_path(merch_1))

      expect(page).to have_content("Percentage discount can't be blank")
    end
  end
end