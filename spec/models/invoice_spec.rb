require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let!(:luffy) {Customer.create!(first_name: "Monkey", last_name: "Luffy")}
  let!(:nami) {Customer.create!(first_name: "Nami", last_name: "Waves")}
  let!(:sanji) {Customer.create!(first_name: "Sanji", last_name: "Foot")}
  let!(:zoro) {Customer.create!(first_name: "Zoro", last_name: "Sword")}

  let!(:invoice_1) {luffy.invoices.create!(status: 2)}
  let!(:invoice_2) {luffy.invoices.create!(status: 2)}
  let!(:invoice_3) {luffy.invoices.create!(status: 2)}
  let!(:invoice_4) {nami.invoices.create!(status: 2)}
  let!(:invoice_5) {nami.invoices.create!(status: 2)}
  let!(:invoice_6) {sanji.invoices.create!(status: 2)}

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
  end
  
  
end
