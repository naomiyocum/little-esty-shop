require 'rails_helper'

RSpec.describe 'Bulk Discount Show Page', type: :feature do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:bulk_1) {nomi.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
  let!(:bulk_2) {nomi.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 50)}
  let!(:bulk_3) {tyty.bulk_discounts.create!(percentage_discount: 5, quantity_threshold: 3)}

  describe 'bulk_discount#show' do
    it 'displays the specific discounts percentage discount and quantity threshold' do
      visit merchant_bulk_discounts_path(nomi)

      within("#bulk-discounts-#{bulk_1.id}") do
        click_link bulk_1.id.to_s
      end

      expect(current_path).to eq(merchant_bulk_discount_path(nomi, bulk_1))

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
      visit merchant_bulk_discount_path(nomi, bulk_1)

      click_link 'Update Discount'

      expect(current_path).to eq(edit_merchant_bulk_discount_path(nomi, bulk_1))
    end
  end
end