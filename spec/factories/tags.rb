FactoryBot.define do
  factory :tag do
    title Faker::HeyArnold.location
    sub_title Faker::HarryPotter.quote
  end
end