FactoryBot.define do
    factory :product do
      name { Faker::Commerce.product_name }
      price { Faker::Commerce.price}
      inventory_count {Faker::Number.between(0,100)}
      id { Faker::Number.number(10) }
      created_by { Faker::Number.number(10) }
    end
  end