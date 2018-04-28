require 'rails_helper'

RSpec.describe Criterion, type: :model do
  it 'has a valid factory' do
    expect(build(:criterion)).to be_valid
  end
end
