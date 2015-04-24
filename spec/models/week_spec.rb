require 'rails_helper'

RSpec.describe Week, type: :model do
  it 'creates a week range for the specified date' do
    week = Week.for_date(Date.strptime('2015-04-24', '%Y-%m-%d'))
    expect(week.id).to be_truthy
    expect(week.beginning.strftime('%d/%m/%Y')).to eq('19/04/2015')
    expect(week.end.strftime('%d/%m/%Y')).to eq('25/04/2015')
  end

  it 'returns an existing week if the date is in between the range' do
    expect {
      week = Week.for_date(Date.strptime('2015-04-22', '%Y-%m-%d'))
    }.to change { Week.count }.by(1)

    expect {
      week = Week.for_date(Date.strptime('2015-04-23', '%Y-%m-%d'))
    }.to change { Week.count }.by(0)
  end
end
