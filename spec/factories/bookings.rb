FactoryBot.define do
  factory :booking do
    time                [Time.now.to_i, (Time.now + 3.hours).to_i]
    estimated_cost      220.0
    association         :user
    association         :course
  end
end