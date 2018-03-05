require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'has a valid factory' do
    expect(build(:review)).to be_valid
  end

  context 'validations' do
    let(:review) { build(:review) }

    it 'requires a content' do
      expect(review).to validate_presence_of(:content)
    end

    it 'requires a valid content' do
      expect(review).to validate_length_of(:content).is_at_most(1000)
    end
  end
end
