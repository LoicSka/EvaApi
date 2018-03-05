require 'rails_helper'

RSpec.describe Subject, type: :model do
  it 'has a valid factory' do
    expect(build(:subject)).to be_valid
  end

  context 'validations' do
    let(:subject) { build(:subject) }

    it 'requires a title' do
      expect(subject).to validate_presence_of(:title)
    end

    it 'requires a valid content' do
      expect(subject).to validate_length_of(:title).is_at_most(200)
    end
  end
end
