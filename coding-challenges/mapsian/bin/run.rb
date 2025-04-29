#!/usr/bin/env ruby

$: << File.expand_path('../../lib', __FILE__)


require 'byebug'

class BallotCounter
  # voting ledger
  # input
  # [candidate1_id, 3]
  # [candidate2_id, 2]
  # [candidate3_id, 1]
  def initialize(candidate_points)
    @candidate_points = candidate_points
    @count = Hash.new(0)
    @results = []
  end

  # returns list of candidates sorted by vote (winner first)
  # [candidate_id]
  def score
    # counts the votes
    @candidate_points.each do |candidate|
      if @count[candidate[0]].nil?
        # add the candidate id
        @results << candidate[0]
      end
      @count[candidate[0]] += candidate[1]
    end

    # sorts the candidates list
    @results.sort do |a, b|
      @count[a] <=> @count[b]
    end

    @results
  end
end