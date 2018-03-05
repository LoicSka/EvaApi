require 'rails_helper'

RSpec.describe Region, type: :model do
  it 'has a valid factory' do
    expect(build(:region)).to be_valid
  end

  context 'validations' do
    let(:region) { build(:region) }

    it 'requires a country name' do
      expect(region).to validate_presence_of(:country_name)
    end

    it 'requires a valid country name' do
      expect(region).to validate_length_of(:country_name).is_at_most(90)
    end

    it 'requires a city name' do
      expect(region).to validate_presence_of(:city_name)
    end

    it 'requires a valid city name' do
      expect(region).to validate_length_of(:city_name).is_at_most(90)
    end

    it 'requires a location' do
      expect(region).to validate_presence_of(:location)
    end

    it 'requires a currency_symbol' do
      expect(region).to validate_presence_of(:currency_symbol)
    end

    it 'requires a valid currency_symbol' do
      expect(region).to validate_length_of(:currency_symbol).is_at_most(1)
    end

  end
end
