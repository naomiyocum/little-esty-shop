require 'faker'

FactoryBot.define do
  factory :bulk_discount do
    percentage_discount {Faker::Number.between(from: 1, to: 75)}
    quantity_threshold {Faker::Number.between(from: 1, to: 60)}
    merchant
  end

  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
  end

  factory :invoice_item do
    quantity {Faker::Number.between(from: 1, to: 100)}
    unit_price {Faker::Number.between(from: 1, to: 1_000)}
    status {rand(0..2)}
    invoice
    item
  end

  factory :invoice do
    status {rand(0..2)}
    customer
  end

  factory :item do
    name {Faker::JapaneseMedia::StudioGhibli.movie}
    description {Faker::JapaneseMedia::StudioGhibli.quote}
    unit_price {Faker::Number.between(from: 1, to: 1_000)}
    merchant
  end

  factory :merchant do
    name {Faker::JapaneseMedia::OnePiece.character}
  end

  factory :transaction do
    credit_card_number {Faker::Number.number(digits: 16)}
    credit_card_expiration_date {Faker::Number.decimal_part(digits: 4)}
    result {rand(0..1)}
    invoice
  end
end