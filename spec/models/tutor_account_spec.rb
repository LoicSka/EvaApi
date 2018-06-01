require 'rails_helper'

RSpec.describe TutorAccount, type: :model do
  it 'has a valid factory' do
    expect(build(:tutor_account)).to be_valid
  end

  # test validations
  context 'validations' do
    let(:tutor_account) { build(:tutor_account) }
    it 'requires a introduction' do
      expect(tutor_account).to validate_presence_of(:introduction)
    end

    it 'requires a valid introduction' do
      expect(tutor_account).to validate_length_of(:introduction).is_at_most(1000)
    end

    it 'requires a valid gender' do
      expect(tutor_account).to validate_inclusion_of(:gender).in_array(%w{ male female })
    end

    it 'requires a valid date of birth' do
      expect(tutor_account).to_not allow_value(Time.now + 2.days).for(:dob)
    end

    it 'requires a phone number' do
      expect(tutor_account).to validate_presence_of(:phone_number)
    end

    it 'requires a valid phone number' do
      expect(tutor_account).to validate_length_of(:phone_number).is_at_most(25)
    end

    it 'requires a valid weibo_url' do
      expect(tutor_account).to validate_length_of(:weibo_url).is_at_most(200)
    end

    it 'requires a valid wechat_id' do
      expect(tutor_account).to validate_length_of(:wechat_id).is_at_most(200)
    end

    it 'requires an occupation' do
      expect(tutor_account).to validate_presence_of(:occupation)
    end

    it 'requires a valid occupation' do
      expect(tutor_account).to validate_inclusion_of(:occupation).in_array(['Full-time tutor','Part-time tutor'])
    end

    it 'requires a state' do
      expect(tutor_account).to validate_presence_of(:state)
    end

    it 'requires a valid state' do
      expect(tutor_account).to validate_inclusion_of(:state).in_array(%w{ trial inactive active })
    end
  end

  context 'methods' do
    let(:tutor_account) { create(:tutor_account) }
    let(:user) { create(:user) }
    # it { expect(tutor_account).to callback(:create_photo).after(:create) }
     it '.available? returns whether tutor account is booked for given days' do
      my_course = create(:course)
      my_course.tutor_account = tutor_account
      my_user = create(:user)
      my_booking = Booking.new(time: [Time.new(2018,05,01).to_i], state: 'accepted')
      my_booking.user = my_user
      my_booking.course = my_course
      my_booking.save!
      expect(tutor_account.available? ([Time.new(2018,05,03).to_i])).to eq(true)
    end

    it '.teaching_experience? returns highest teaching_experience value from tutor account courses ' do
      course_1 = create(:course, tutor_account: tutor_account, teaching_experience: 0)
      course_2 = create(:course, tutor_account: tutor_account, teaching_experience: 3)
      expect(tutor_account.teaching_experience).to eq(3)
    end
  end

end
