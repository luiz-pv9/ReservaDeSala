require 'rails_helper'

RSpec.describe ScheduleHelper, :type => :helper do
  describe "#headers" do
    it 'is a list of the headers of the schedule table' do
      expect(helper.headers).to eq([
        'Horário',
        'Segunda',
        'Terça',
        'Quarta',
        'Quinta',
        'Sexta'
      ])
    end
  end

  describe '#horarios' do
    it 'returns a list of available times for scheduling' do
      expect(helper.horarios).to eq((6..23).to_a)
    end
  end

  describe '#horario_format' do
    it 'formats for a single-digit' do
      expect(helper.horario_format(5)).to eq('05:00')
      expect(helper.horario_format(9)).to eq('09:00')
    end

    it 'formats for two-digit' do
      expect(helper.horario_format(13)).to eq('13:00')
    end
  end

  describe '#has_reservation' do
    before :each do
      @user = User.create(:username => 'lpvasco', :password => '1234')
      @week = Week.for_date(Time.now)
      Reservation.create(:user => @user, :week => @week, :day_index => 1, :time_start => 5, :time_end => 6)
      Reservation.create(:user => @user, :week => @week, :day_index => 2, :time_start => 5, :time_end => 6)
      Reservation.create(:user => @user, :week => @week, :day_index => 1, :time_start => 8, :time_end => 9)
      @reservations = Reservation.where(:week_id => @week.id)
    end

    it 'returns true if the reservation is present in the list' do
      expect(helper.has_reservation(@reservations, 1, 5)).to be_truthy
      expect(helper.has_reservation(@reservations, 1, 8)).to be_truthy
      expect(helper.has_reservation(@reservations, 2, 5)).to be_truthy
    end

    it 'returns false if the reservation is not in the list' do
      expect(helper.has_reservation(@reservations, 3, 5)).to be(nil)
      expect(helper.has_reservation(@reservations, 1, 9)).to be(nil)
      expect(helper.has_reservation(@reservations, 2, 6)).to be(nil)
    end
  end
end