require './algo'

sum = 0
(1..2_000_000).each do |x|
  if is_prime?(x)
    sum += x
  end
end

puts sum