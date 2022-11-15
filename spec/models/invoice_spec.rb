require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  let!(:luffy) {Customer.create!(first_name: "Monkey", last_name: "Luffy")}
  let!(:nami) {Customer.create!(first_name: "Nami", last_name: "Waves")}
  let!(:sanji) {Customer.create!(first_name: "Sanji", last_name: "Foot")}
  let!(:zoro) {Customer.create!(first_name: "Zoro", last_name: "Sword")}

  let!(:invoice_1) {luffy.invoices.create!(status: 2, created_at: Time.parse("22.11.03"))}
  let!(:invoice_2) {luffy.invoices.create!(status: 2)}
  let!(:invoice_3) {luffy.invoices.create!(status: 2)}
  let!(:invoice_4) {nami.invoices.create!(status: 2)}
  let!(:invoice_5) {nami.invoices.create!(status: 2)}
  let!(:invoice_6) {sanji.invoices.create!(status: 2)}

  let!(:invoice_item_1)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 2999, status: "shipped")}
  let!(:invoice_item_2)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_3.id, quantity: 10, unit_price: 300, status: "packaged")}
  let!(:invoice_item_3)  {InvoiceItem.create!(item_id: lamp.id, invoice_id: invoice_5.id, quantity: 2, unit_price: 2999, status: "packaged")}
  let!(:invoice_item_4)  {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_6.id, quantity: 5, unit_price: 100, status: "shipped")}
  let!(:invoice_item_5)  {InvoiceItem.create!(item_id: stickers.id, invoice_id: invoice_6.id, quantity: 1, unit_price: 100, status: "shipped")}
  let!(:invoice_item_6)  {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_6.id, quantity: 1, unit_price: 1000, status: "shipped")}
  let!(:invoice_item_7)  {InvoiceItem.create!(item_id: orion.id, invoice_id: invoice_4.id, quantity: 1, unit_price: 1000, status: "packaged")}
  let!(:invoice_item_8)  {InvoiceItem.create!(item_id: oil.id, invoice_id: invoice_4.id, quantity: 10, unit_price: 2599, status: "packaged")}
  let!(:invoice_item_9)  {InvoiceItem.create!(item_id: pants.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 2100, status: "packaged")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}
  let!(:orion) {nomi.items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850)}
  let!(:oil) {tyty.items.create!(name: "Special Chili Oil", description: "Random One Piece and Death Note stickers", unit_price: 800)}
  let!(:water) {tyty.items.create!(name: "The Best Water Ever", description: "from the great Cherry Creek Reservoir", unit_price: 100)}
  let!(:shirt) {tyty.items.create!(name: "Funny Shirt", description: "nice", unit_price: 1099)}
  let!(:pants) {tyty.items.create!(name: "Pants", description: "nice", unit_price: 2010)}
  
  let!(:discount_10off) {BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: nomi.id)}
  
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:transactions)}
  end

  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'class methods' do
    describe '#uniq_invoices' do
      it 'returns unique invoices' do
        expect(Invoice.uniq_invoices.count).to eq(6)
      end
    end

    describe "incomplete_invoices" do
      it 'should show incomplete invoices' do
        expect(Invoice.incomplete_invoices).to include(invoice_2, invoice_5, invoice_4, invoice_3)
      end
    end
  end

  describe 'instance methods' do
    describe '#my_total_revenue' do
      it 'returns the total revenue for a specific merchant' do
        expect(invoice_1.my_total_revenue(nomi)).to eq(5998)
      end
    end

    describe '#my_total_revenue_formatter' do
      it 'formats the total revenue to have two decimal places' do
        expect(invoice_1.my_total_revenue_formatter(nomi)).to eq("59.98")
      end
    end

    describe '#admin_total_revenue' do
      it 'returns the total revenue for a specific merchant' do
        expect(invoice_1.admin_total_revenue(invoice_1)).to eq(5998)
      end
    end

    describe '#admin_revenue_formatter' do
      it 'formats the revenue' do
        expect(invoice_1.admin_revenue_formatter(invoice_1)).to eq("59.98")
      end
    end

    describe '#total_discount' do
      it 'returns the value of the total discount on an invoice' do

        expect(invoice_3.total_discount).to eq(300)
      end

      it 'returns the valude of the total discount with only one discount' do
        @merchant_test = Merchant.create!(name: "test")
        @customer_test = Customer.create!(first_name: "test", last_name: "yes")
        @item_test = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        @invoice_test = Invoice.create!(status: 1, customer_id: @customer_test.id)
        @invoice_item_test = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test.id, quantity: 10, unit_price: 100, status: 1)
        @discount_test = BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: @merchant_test.id)
        
        expect(@invoice_test.total_discount).to eq(100)
      end

      it 'has two items both count of 5 should have no discount applied' do
        @merchant_test = Merchant.create!(name: "test")
        
        @customer_test = Customer.create!(first_name: "test", last_name: "yes")
        
        @item_test = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        @item_test2 = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        
        @invoice_test = Invoice.create!(status: 1, customer_id: @customer_test.id)
        
        @invoice_item_test = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test.id, quantity: 5, unit_price: 100, status: 1)
        @invoice_item_test2 = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test2.id, quantity: 5, unit_price: 100, status: 1)
        
        @discount_test = BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: @merchant_test.id)
        
        expect(@invoice_test.total_discount).to eq(0)
      end

      it 'returns the value of the total discount of the highest applicable discount' do
        @merchant_test = Merchant.create!(name: "test")        
        @customer_test = Customer.create!(first_name: "test", last_name: "yes")        
        @item_test = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)        
        @invoice_test = Invoice.create!(status: 1, customer_id: @customer_test.id)        
        @invoice_item_test = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test.id, quantity: 10, unit_price: 100, status: 1)
        @discount_test = BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: @merchant_test.id)
        @discount_test_2 = BulkDiscount.create!(name: "20 off for 10 items", threshold: 10, percentage_discount: 20, merchant_id: @merchant_test.id)
        
        expect(@invoice_test.total_discount).to eq(200)
      end

      it 'returns the valude of the total discount when no discounts apply' do
        @merchant_test = Merchant.create!(name: "test")
        @customer_test = Customer.create!(first_name: "test", last_name: "yes")
        @item_test = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        @invoice_test = Invoice.create!(status: 1, customer_id: @customer_test.id)
        @invoice_item_test = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test.id, quantity: 9, unit_price: 100, status: 1)
        @discount_test = BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: @merchant_test.id)
        @discount_test_2 = BulkDiscount.create!(name: "20 off for 10 items", threshold: 10, percentage_discount: 20, merchant_id: @merchant_test.id)
        
        expect(@invoice_test.total_discount).to eq(0)
      end

      it 'returns the discount of 10 percent off for one merchants items but not the others' do
        @merchant_test = Merchant.create!(name: "test")
        @merchant_test_2 = Merchant.create!(name: "test 2")

        @customer_test = Customer.create!(first_name: "test", last_name: "yes")

        @item_test = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        @item_test_2 = Item.create!(name: "stuff", description: "for test", merchant_id: @merchant_test_2.id, unit_price: 100, status: 1)
        
        @invoice_test = Invoice.create!(status: 1, customer_id: @customer_test.id)
        
        @invoice_item_test = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test.id, quantity: 10, unit_price: 100, status: 1)
        @invoice_item_test_2 = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test_2.id, quantity: 10, unit_price: 100, status: 1)
        
        @discount_test = BulkDiscount.create!(name: "10 off for 10 items", threshold: 10, percentage_discount: 10, merchant_id: @merchant_test.id)
        
        expect(@invoice_test.total_discount).to eq(100)
      end

      it 'returns two discounts from the same merchant that are both applicable' do
        @merchant_test = Merchant.create!(name: "test")

        @customer_test = Customer.create!(first_name: "test", last_name: "yes")

        @item_test = Item.create!(name: "fiction", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        @item_test_2 = Item.create!(name: "stuff", description: "for test", merchant_id: @merchant_test.id, unit_price: 100, status: 1)
        
        @invoice_test = Invoice.create!(status: 1, customer_id: @customer_test.id)
        
        @invoice_item_test = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test.id, quantity: 12, unit_price: 100, status: 1)
        @invoice_item_test_2 = InvoiceItem.create!(invoice_id: @invoice_test.id, item_id: @item_test_2.id, quantity: 15, unit_price: 100, status: 1)
        
        @discount_test = BulkDiscount.create!(name: "30 off for 15 items", threshold: 15, percentage_discount: 30, merchant_id: @merchant_test.id)
        @discount_test2 = BulkDiscount.create!(name: "20 off for 10 items", threshold: 10, percentage_discount: 20, merchant_id: @merchant_test.id)
        
        expect(@invoice_test.total_discount).to eq(690)
      end
    end

    describe '#discount_format' do
      it 'should format the disount into dollars' do
        expect(invoice_3.discount_format).to eq(3.00)
      end
    end
  end
end
