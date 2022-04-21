# https://www.robertdickau.com/lattices.html

require 'byebug'
require 'set'


def connections_from(pos, size)
  results = []

  if pos[0] > 0
    results << [pos[0] - 1, pos[1]]
  end

  if pos[1] > 0
    results << [pos[0], pos[1] - 1]
  end

  results
end

def next_connections(pos, size)
  results = []

  if pos[0] < size
    results << [pos[0] + 1, pos[1]]
  end

  if pos[1] < size
    results << [pos[0], pos[1] + 1]
  end

  results
end

start = [0, 0]
weights = Hash.new(0)
weights[start] = 1
size = 20

queue = [start]
visited = Set.new

while queue.any?
  position = queue.shift

  connections_from(position, size).each do |prev|
    weights[position] += weights[prev]
  end

  next_connections(position, size).each do |next_pos|
    unless visited.member?(next_pos)
      queue << next_pos
      visited << next_pos
    end
  end
end

puts weights[[size, size]]
