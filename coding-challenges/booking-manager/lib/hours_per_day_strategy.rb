require 'date'
require 'daily_limit_strategy'

# Max hours per day per visitor
class HoursPerDayStrategy < DailyLimitStrategy
  def initialize(max_hours_per_day)
    super(max_hours_per_day * 3600)
  end

  protected

  def key_of(booking)
    booking.visitor
  end

  def usage_of(booking)
    booking.duration
  end
end