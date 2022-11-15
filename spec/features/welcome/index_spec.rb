require 'rails_helper'

RSpec.describe 'the Welcome Page', type: :feature do
  let!(:merch_1) {create(:merchant)}

  describe 'welcome#index' do
    it 'searches for the merchant and takes to the correct dashboard' do
      visit root_path

      expect(page).to have_field :search
      
      fill_in :search, with: merch_1.id
      click_on 'Find Me'

      expect(current_path).to eq(merchant_dashboard_index_path(merch_1))
    end

    it 'gives an error message and returns back to the same page when a merchant ID does not exist' do
      visit root_path
      
      fill_in :search, with: 100
      click_on 'Find Me'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Merchant #100 Does Not Exist')
    end
  end
end