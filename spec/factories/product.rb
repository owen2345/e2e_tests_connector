FactoryBot.define do
  factory :product do
    title { 'Product title' }
    description { 'product description here' }
    user
  end
end
