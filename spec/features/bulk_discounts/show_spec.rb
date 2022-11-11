require 'rails_helper'

RSpec.describe 'Bulk Discount Show Page', type: :feature do
  let!(:merch_1) {create(:merchant)}
  let!(:merch_2) {create(:merchant)}

  let!(:bulk_1) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_2) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_3) {create(:bulk_discount, merchant: merch_1)}
  let!(:bulk_4) {create(:bulk_discount, merchant: merch_2)}
  let!(:bulk_5) {create(:bulk_discount, merchant: merch_2)}
  let!(:bulk_6) {create(:bulk_discount, merchant: merch_2)}

  let!(:item_1) {create(:item, merchant: merch_1)}
  let!(:item_2) {create(:item, merchant: merch_1)}
  let!(:item_3) {create(:item, merchant: merch_1)}
  let!(:item_4) {create(:item, merchant: merch_2)}
  let!(:item_5) {create(:item, merchant: merch_2)}
  let!(:item_6) {create(:item, merchant: merch_2)}

  describe 'bulk_discount#show' do
    it 'displays the specific discounts percentage discount and quantity threshold' do
      visit merchant_bulk_discounts_path(merch_1)
    
      within("#bulk-discounts-#{bulk_1.id}") do
        click_link bulk_1.id.to_s
      end

      expect(current_path).to eq(merchant_bulk_discount_path(merch_1, bulk_1))

      within("#percentage") do
        expect(page).to have_content("Percentage Discount")
        expect(page).to have_content("#{bulk_1.percentage_discount}%")
      end

      within("#quantity") do
        expect(page).to have_content("Quantity Threshold")
        expect(page).to have_content(bulk_1.quantity_threshold)
      end
    end

    it 'when I click a link to update the discount I am taken to the edit page' do
      visit merchant_bulk_discount_path(merch_1, bulk_1)

      click_link 'Update Discount'

      expect(current_path).to eq(edit_merchant_bulk_discount_path(merch_1, bulk_1))
    end
  end
end