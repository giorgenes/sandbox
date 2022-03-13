class TokenBucket
  attr_reader :tokens

  def initialize(max: 1, rate: 1, interval: 1)
    @max = max
    @rate = rate
    @tokens = max
    @last_refill = Time.new(1970)
    @interval = interval
  end

  def consume!
    refill

    if @token > 0
      @tokens -= 1
      @tokens = 0 if @tokens < 0
    else
      raise "no tokens available"
    end
  end

  private

  def refill
    diff = (Time.now - @last_refill) / @interval.to_f

    new_tokens = (@rate * diff).to_i

    @tokens = [@max, @tokens + new_tokens].min
  end
end