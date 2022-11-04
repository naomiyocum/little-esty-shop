require "rails_helper"

RSpec.describe "admin merchant index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")
    visit "/admin/merchants"
  end

  it "shows name of each merchant" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
  end

  it "each name links to show page" do
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@merchant_2.name)
    expect(page).to have_link(@merchant_3.name)
    expect(page).to have_link(@merchant_4.name)
    expect(page).to have_link(@merchant_5.name)
    click_on "#{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it "has button to enable" do
    expect(page).to have_content("Disabled Merchants")
  within "#disabled_merchant-#{@merchant_1.id}" do
      click_on "Enable"
      expect(@merchant_1.reload.status).to eq("enabled")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it "has button to disable" do
    expect(page).to have_content("Enabled Merchants")
    within "#disabled_merchant-#{@merchant_1.id}" do
      click_on "Enable"
      expect(@merchant_1.reload.status).to eq("enabled")
      expect(current_path).to eq("/admin/merchants")
    end

  within "#enabled_merchant-#{@merchant_1.id}" do
      click_on "Disable"
      expect(@merchant_1.reload.status).to eq("disabled")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it "link to create new merchant" do
    click_link "New Merchant"
    expect(current_path).to eq("/admin/merchants/new")
  end
end

  describe "admin merchant index page pt2 " do
    before :each do
      @merchant_1 = Merchant.create!(name: "Naomi LLC")
      @merchant_2 = Merchant.create!(name: "TyTy's Grub")

      @customer_1 = Customer.create!(first_name: "Monkey", last_name: "Luffy")
      @customer_2 = Customer.create!(first_name: "Nami", last_name: "Waves")
      @customer_3 = Customer.create!(first_name: "Sanji", last_name: "Foot")
      @customer_4 = Customer.create!(first_name: "Zoro", last_name: "Sword")

      @invoice_1 = @customer_1.invoices.create!(status: 2)
      @invoice_2 = @customer_1.invoices.create!(status: 2)
      @invoice_3 = @customer_1.invoices.create!(status: 2)
      @invoice_4 = @customer_2.invoices.create!(status: 2)
      @invoice_5 = @customer_2.invoices.create!(status: 2)
      @invoice_6 = @customer_3.invoices.create!(status: 2)
      @invoice_7 = @customer_3.invoices.create!(status: 2)
      @invoice_8 = @customer_3.invoices.create!(status: 2)
      @invoice_9 = @customer_3.invoices.create!(status: 2)
      @invoice_10 = @customer_4.invoices.create!(status: 2)
      @invoice_11 = @customer_4.invoices.create!(status: 2)
      @invoice_12 = @customer_4.invoices.create!(status: 2)

      @item_1 = @merchant_1.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)
      @item_2 = @merchant_1.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)
      @item_3 = @merchant_1.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)
      @item_4 = @merchant_2.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)
      @item_5 = @merchant_2.items.create!(name: "The Best Water Ever", description: "from the great Cherry Creek Reservoir", unit_price: 100)
      @item_6 = @merchant_2.items.create!(name: "Funny Shirt", description: "nice", unit_price: 1099)
      @item_7 = @merchant_2.items.create!(name: "Pants", description: "nice", unit_price: 2010)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 2999, status: "shipped")
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 2999, status: "shipped")
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_5.id, quantity: 2, unit_price: 2999, status: "shipped")
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_7.id, quantity: 5, unit_price: 100, status: "shipped")
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: 100, status: "shipped")
      @invoice_item_6 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: 1000, status: "shipped")
      @invoice_item_7 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: 1000, status: "shipped")
      @invoice_item_8 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_11.id, quantity: 10, unit_price: 2599, status: "shipped")
      @invoice_item_9 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 2100, status: "shipped")


      @transaction_1 = Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: @invoice_2.id)
      @transcation_3 = Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: @invoice_3.id)
      @transaction_4 = Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: @invoice_4.id)
      @transaction_5 = Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_5.id)
      @transaction_6 = Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_6.id)
      @transaction_7 = Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_7.id)
      @transaction_8 = Transaction.create!(credit_card_number: 1555555555555555, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_8.id)
      @transaction_9 = Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_9.id)
      @transaction_10 = Transaction.create!(credit_card_number: 1000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_10.id)
      @transaction_11 = Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_11.id)
      @transaction_12 = Transaction.create!(credit_card_number: 2000000000000000, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_12.id)
      visit "/admin/merchants"
    end

    it "has top 5 merchants" do
      expect(page).to have_content("Top Merchants")
    end
  end
