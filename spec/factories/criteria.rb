FactoryBot.define do
  factory :criterion do
    type          %w(AGE_GROUP TUTOR_GENDER CURRENT_LEVEL WEAK_POINTS DISTRICT).sample
    values        ['text']
    association   :student
  end
end