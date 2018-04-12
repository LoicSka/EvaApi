require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'has a valid factory' do
    expect(build(:tag)).to be_valid
  end

  context 'validations' do
    let(:tag) { build(:tag) }
    it 'requires a title' do
      expect(tag).to validate_presence_of(:title)
    end

    it 'requires a valid title' do
      expect(tag).to validate_length_of(:title).is_at_most(500)
    end
  end
end
