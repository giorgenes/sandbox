require 'booking_request'
require 'set'

class BookingManager
  def initialize
    @strategies = []
  end

  # Evaluate the booking requests
  # Returns:
  #   - An array with with the visitors who are denied access
  def evaluate(booking_requests)
    reject_list = Set.new

    booking_requests.each do |booking_request|
      # FIXME: validate this
      dt, duration, visitor, resident = booking_request

      # FIXME: validate this
      hour, min = duration.split(':').map(&:to_i)
      seconds = hour * 60 * 60 + (min * 60)

      # FIXME: validate date / handle error
      request = BookingRequest.new(Time.parse(dt), seconds, visitor, resident)
      @strategies.each do |strategy|
        unless strategy.evaluate(request)
          reject_list.add(request.visitor)
        end
      end
    end

    reject_list.to_a
  end

  def add_strategy(strategy)
    @strategies << strategy
  end
end