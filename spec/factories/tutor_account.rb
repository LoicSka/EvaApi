FactoryBot.define do
  factory :tutor_account do
    gender          'male'
    dob             24.years.ago
    introduction    Faker::HarryPotter.quote
    phone_number    Faker::PhoneNumber.cell_phone
    weibo_url       Faker::Internet.url('weibo.com/users')
    wechat_url      Faker::Internet.url('wechat.com/users')
    occupation      'professional'
    days_available  []
    state           'active'
    renewed_at      Time.now
    expiring_at     Time.now + 2.weeks

    association   :user
    association   :region
  end
end