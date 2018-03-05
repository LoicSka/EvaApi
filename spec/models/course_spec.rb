require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'has a valid factory' do
    expect(build(:course)).to be_valid
  end

  context 'validations' do
    let(:course) { build(:course) }
    it 'requires a teaching experience' do
      expect(course).to validate_presence_of(:teaching_experience)
    end

    it 'requires a valid teaching experience' do
      expect(course).to validate_inclusion_of(:teaching_experience).in_array([0,1,2,3])
    end

    it 'requires a valid age group' do
      expect(course).to validate_inclusion_of(:age_group).in_array([0,1,2,3,4])
    end

  end
end
