FactoryBot.define do
  factory :region do
    country_name       Faker::Address.country
    city_name          Faker::Address.city
    district          Faker::Address.city
    location           [Faker::Address.longitude, Faker::Address.latitude]
    currency_symbol    '¥'
  end
end