FactoryBot.define do
  factory :course do
    teaching_experience     1
    age_group               1
    title                   Faker::TheFreshPrinceOfBelAir.character
    description             Faker::HarryPotter.quote
    expertise               1
    hourly_rate             123
    
    association             :subject
    association             :tutor_account
  end
end