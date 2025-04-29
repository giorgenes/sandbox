class Ballot
  # voting ledger
  # input
  # [candidate1_id, 3]
  # [candidate2_id, 2]
  # [candidate3_id, 1]
  # input is expected to validated with correct points
  # and candidates be valid
  def initialize(candidate_points)
    @candidate_points = candidate_points
    @count = Hash.new(0)
    @tie_count = Hash.new(0)
    @results = []
  end

  # returns list of candidates sorted by vote (winner first)
  # [candidate_id]
  def score
    # counts the votes
    @candidate_points.each do |candidate|
      c_id, points = candidate

      if @count[c_id] == 0
        # add the candidate id
        @results << c_id
      end
      @count[c_id] += points

      # is first option?
      if points == 3
        @tie_count[c_id] += 1
      end
    end

    # sorts the candidates list
    @results.sort! do |a, b|
      # make a compound score, with last 32 bits being the tie score
      score_a = (@count[a] << 32) + @tie_count[a]
      score_b = (@count[b] << 32) + @tie_count[b]

      score_b <=> score_a
    end

    @results
  end
end