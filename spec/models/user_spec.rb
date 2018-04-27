require 'rails_helper'

RSpec.describe User, type: :model do
  # test factory validity
  it 'has a valid factory' do
    expect(build (:user)).to be_valid
  end

  # test validations
  context 'validations' do
    let(:user) { build(:user) }

    # check the length of the first_name
    it 'requires a first name' do
      expect(user).to validate_presence_of(:first_name)
    end

    it 'requires a valid first name' do
      expect(user).to validate_length_of(:first_name).is_at_most(50)
    end

    it 'requires a last name' do
      expect(user).to validate_presence_of(:last_name)
    end

    it 'requires a valid last name' do
      expect(user).to validate_length_of(:last_name).is_at_most(50)
    end

    # it 'requires a unique email' do
    #   expect(user).to validate_uniqueness_of(:email)
    # end

    it 'requires a valid email' do
      expect(user).to allow_value('dhh@opinionated.com').for(:email)
      expect(user).to_not allow_value('base@example').for(:email)
      expect(user).to_not allow_value('blah').for(:email)
    end
  end

  context 'methods' do
    let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }
    it { expect(user).to callback(:lowercase_email).before(:save) }

    it '.password assigns password hash' do
      expect{ user.password= 'exapmplepassword' }.to change(user, :password_hash)
    end

    it '.full_name return the user\'s fullname' do
      expect(user.full_name).to eq('John Doe')
    end

    it '.lowercase_email downcases user\'s email' do
      user.email = 'EXAMPLE@yahoo.com'
      expect{ user.lowercase_email }.to change(user, :email).from('EXAMPLE@yahoo.com').to('example@yahoo.com')
    end

  end

end
