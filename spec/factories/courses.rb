FactoryBot.define do
  factory :course do
    teaching_experience     1
    age_group               1

    association             :subject
    association             :tutor_account
  end
end