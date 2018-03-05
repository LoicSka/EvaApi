require 'rails_helper'

RSpec.describe Booking, type: :model do
  it 'has a valid factory' do
    expect(build(:booking)).to be_valid
  end

  context 'validations' do
    let(:booking) { build(:booking)}

    # check if the time is provided
    it 'requires a time' do
      expect(booking).to validate_presence_of(:time)
    end
  end
end
