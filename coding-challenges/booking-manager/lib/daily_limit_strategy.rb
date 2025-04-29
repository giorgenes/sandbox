# Generic 'daily limit' strategy
# Children classes can implement `usage_of` and `key_of` to control
# what's being limited and by how much
class DailyLimitStrategy
  def initialize(limit)
    @limit = limit
    @limits_table = Hash.new
  end

  def evaluate(booking)
    key = key_of(booking)
    day_slot = (@limits_table[booking.jd] ||= Hash.new)
    day_slot[key] ||= 0

    if day_slot[key] >= @limit
      return false
    else
      day_slot[key] += usage_of(booking)
    end

    true
  end

  protected

  # accumulate this amount against the limit
  def usage_of(booking)
    raise NoMethodError
  end

  # the key to limit for on each day
  def key_of(booking)
    raise NoMethodError
  end
end