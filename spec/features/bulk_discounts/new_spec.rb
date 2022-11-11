require 'rails_helper'

RSpec.describe 'Bulk Discount New Discount', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:bulk_1) {nomi.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
  let!(:bulk_2) {nomi.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 50)}
  let!(:bulk_3) {tyty.bulk_discounts.create!(percentage_discount: 5, quantity_threshold: 3)}

  describe 'bulk_discount#create' do
    it 'after submitting the form with valid data, I am redirected back to the index page and see the new discount' do
      visit new_merchant_bulk_discount_path(nomi)

      fill_in :percentage_discount, with: 34
      fill_in :quantity_threshold, with: 19

      click_button 'Create New Discount'

      new_discount = BulkDiscount.last
      
      expect(page).to have_content("Successfully Created #{new_discount.id}")
      expect(current_path).to eq(merchant_bulk_discounts_path(nomi))

      within "#bulk-discounts-#{new_discount.id}" do
        expect(page).to have_content(new_discount.id)
        expect(page).to have_content("Percentage Discount: #{new_discount.percentage_discount}")
        expect(page).to have_content("Quantity Threshold: #{new_discount.quantity_threshold}")
      end
    end

    it 'returns an error message if fields are not filled correctly' do
      visit new_merchant_bulk_discount_path(nomi)
      
      fill_in :percentage_discount, with: ' '
      fill_in :quantity_threshold, with: 23

      click_button 'Create New Discount'
      
      expect(current_path).to eq(new_merchant_bulk_discount_path(nomi))

      expect(page).to have_content("Percentage discount can't be blank")
    end
  end
end