class VisitingHoursStrategy
  def initialize(from:, to:)
    @from = from
    @to = to
  end

  def evaluate(booking)
    if booking.visit_at.hour >= @from && booking.visit_at.hour <= @to && (booking.visit_at + booking.duration).hour <= @to
      return true
    end
    # if booking.visit_at.hour < @from || booking.visit_at.hour > @to
    #   return false
    # end

    false
  end
end
