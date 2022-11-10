require 'rails_helper'

RSpec.describe "admin merchant show page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")
    visit "/admin/merchants/#{@merchant_1.id}"
  end

  it "link to update merchant's info" do
    click_link "Update Merchant Info"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
  end

  # it "shows github infos" do
  #   visit "/admin/merchants"
  #   expect(page).to have_content("little-esty-shop")
  #   expect(page).to have_content("naomiyocum")
  #   expect(page).to have_content("Shawnl93")
  #   expect(page).to have_content("Yuji3000")
  #   expect(page).to have_content("knestler")
  # end
end
