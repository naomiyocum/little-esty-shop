require 'rails_helper'

  RSpec.describe 'Admin Invoices Show Page' do
    before :each do 
      @customer_1 = Customer.create!(first_name: "Sally", last_name: "Shopper")
      @invoice_1 = Invoice.create!(status: "in progress", customer_id: @customer_1.id, created_at: Time.parse("22.11.03"))
    end
    
    it 'has information related to that invoice - id, status, created, name' do
      visit admin_invoice_path(@invoice_1)
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content("in progress")
      expect(page).to have_content("Thursday, November 03, 2022")
      expect(page).to have_content("Sally")
      expect(page).to have_content("Shopper")
    end

  end
