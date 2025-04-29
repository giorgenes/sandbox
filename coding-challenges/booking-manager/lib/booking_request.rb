require 'date'

BookingRequest = Struct.new(:visit_at, :duration, :visitor, :resident) do
  def jd
    visit_at.to_date.jd
  end
end