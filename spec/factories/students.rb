FactoryBot.define do
  factory :student do
    fullname      Faker::HarryPotter.character
    association   :user
  end
end