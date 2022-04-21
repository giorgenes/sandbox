require './algo'

max = 0
num = nil
999_999.downto(1).each do |x|
  size = collatz_sequence(x, 1_000_000).to_a.size
  if size > max
    max = size
    num = x
  end
end

puts num