FactoryBot.define do
  factory :review do
    content       Faker::HarryPotter.quote
    association   :tutor_account
    association   :user
  end
end