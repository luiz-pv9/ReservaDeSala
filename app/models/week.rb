class Week < ActiveRecord::Base
  def self.for_date(date)
    beginning_date = date.beginning_of_week(start_day = :sunday).beginning_of_day
    end_date = date.end_of_week(start_day = :sunday).end_of_day

    record = Week.where(:beginning => beginning_date, :end => end_date).first
    unless record
      record = Week.create(:beginning => beginning_date, :end => end_date)
    end
    record
  end
end
