require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'requires a username' do
      user = User.new(:password => '1234')
      expect(user).not_to be_valid
    end

    it 'require password' do
      user = User.new(:username => 'lpvasco')
      expect(user).not_to be_valid
    end

    it 'has a unique username' do
      user = User.create(:username => 'lpvasco', :password => '1234')
      expect(user).to be_valid
      user2 = User.create(:username => 'lpvasco', :password => '1234')
      expect(user2).not_to be_valid
    end
  end

  it 'authenticates by the password' do
    user = User.create(:username => 'lpvasco', :password => '1234')
    expect(user.authenticate('1234')).to eq(user)
    expect(user.authenticate('_1234')).to be(false)
  end
end
