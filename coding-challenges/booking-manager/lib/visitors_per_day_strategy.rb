require 'daily_limit_strategy'

# Max visits per day per resident strategy
class VisitorsPerDayStrategy < DailyLimitStrategy
  def initialize(max_visits_per_day)
    super(max_visits_per_day)
  end

  protected

  # visits per per day a resident can get
  def key_of(booking)
    booking.resident
  end

  # each visit accounts to 1 on the limit
  def usage_of(booking)
    1
  end
end