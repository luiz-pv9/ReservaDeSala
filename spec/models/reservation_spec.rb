require 'rails_helper'

RSpec.describe Reservation, type: :model do
  def user
    @user ||= User.create(:username => 'lpvasco', :password => '1234')
  end

  def week
    @week ||= Week.for_date(Date.strptime('2015-04-24', '%Y-%m-%d'))
  end

  describe 'attribute validation' do
    it 'requires a week' do
      res = Reservation.new(:user => user, :time_start => 1, :time_end => 2, :day_index => 1)
      expect(res).not_to be_valid
    end

    it 'requires a user' do
      res = Reservation.new(:week => week, :time_start => 1, :time_end => 2, :day_index => 1)
      expect(res).not_to be_valid
    end

    it 'requires a time_start' do
      res = Reservation.new(:user => user, :week => week, :time_end => 2, :day_index => 1)
      expect(res).not_to be_valid
    end

    it 'requires a time_end' do
      res = Reservation.new(:user => user, :week => week, :time_start => 1, :day_index => 1)
      expect(res).not_to be_valid
    end

    it 'requires a day_index' do
      res = Reservation.new(:user => user, :week => week, :time_start => 1, :time_end => 2)
      expect(res).not_to be_valid
    end

    it 'requires a unique week_id, day_index and time_start combination' do
      res = Reservation.create(:user => user, :week => week, :time_start => 1, 
        :time_end => 2, :day_index => 0)
      res2 = Reservation.new(:user => user, :week => week, :time_start => 1, 
        :time_end => 2, :day_index => 0)

      expect(res2).not_to be_valid
      res2.time_start = 2
      expect(res2).to be_valid
    end
  end
end
