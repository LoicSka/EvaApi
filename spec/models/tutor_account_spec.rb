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

    it 'requires a valid wechat_url' do
      expect(tutor_account).to validate_length_of(:wechat_idl).is_at_most(200)
    end

    it 'requires an occupation' do
      expect(tutor_account).to validate_presence_of(:occupation)
    end

    it 'requires a valid occupation' do
      expect(tutor_account).to validate_inclusion_of(:occupation).in_array(%w{ professional part-time })
    end

    it 'requires that past dates be invalid' do
      expect(tutor_account).to_not allow_value([Time.now - 2.days]).for(:days_available)
    end

    it 'requires a availble days to be in the future' do
      expect(tutor_account).to allow_value([Time.now + 2.days]).for(:days_available)
    end

    it 'requires a state' do
      expect(tutor_account).to validate_presence_of(:state)
    end

    it 'requires a valid state' do
      expect(tutor_account).to validate_inclusion_of(:state).in_array(%w{ trial inactive active })
    end

  end
end
