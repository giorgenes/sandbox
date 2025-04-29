class Rate
  def initialize
    @new_map = Hash.new(0)
    @last_slot = 0
  end

  MAX_REQ = 5
  WINDOW_SIZE = 10

  def rate_limit(identifier)
    slot = Time.now.to_i / WINDOW_SIZE.to_i

    credits = 0
    key = identifier

    # watch out for race conditional
    if slot > @last_slot
      @last_slot = slot
      credits = MAX_REQ - @new_map[key].to_i

      @new_map = Hash.new(0)
      @new_map[key] -= credits
    end

    @new_map[key] += 1
    if @new_map[key] > MAX_REQ
      return false
    else
      return true
    end
  end
end