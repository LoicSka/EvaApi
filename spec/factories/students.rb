FactoryBot.define do
  factory :student do
    full_name         Faker::HarryPotter.character
    gender            %w{male female}.sample
    days_available    %w{monday tuesday wednesday thursday friday saturday sunday}.sample 3
    association   :region
    association   :subject
  end
end