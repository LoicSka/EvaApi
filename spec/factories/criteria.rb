FactoryBot.define do
  factory :criterion do
    type          %w(age tutor_gender)
    value         Faker::HarryPotter.character
    association   :student
  end
end