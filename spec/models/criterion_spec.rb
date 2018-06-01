require 'rails_helper'

RSpec.describe Criterion, type: :model do
  it 'has a valid factory' do
    expect(build(:criterion)).to be_valid
  end
  context 'validations' do
    let(:criterion) { build(:criterion) }
    it 'requires a type' do
      expect(criterion).to validate_presence_of(:type)
    end
    it 'requires values' do
      expect(criterion).to validate_presence_of(:values)
    end
  end

  context 'methods' do
    let(:criterion) { create(:criterion, type: 'TUTOR_GENDER', values: ['male'] ) }
    it '.score_for return correct score' do
      tutor_account = create(:tutor_account, age_group: 1, gender: 'male')
      expect(criterion.score_for tutor_account).to eq(2)
    end
  end
end

