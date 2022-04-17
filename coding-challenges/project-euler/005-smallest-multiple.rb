require './algo'

# remove elements from v found in z
def remove_each_from(v, z)
  v.each do |num|
    index = z.index(num)
    z.delete_at(index) if index
  end
end


# first we get all the prime factors for each number from 1..20
primes = (1..20).map { |x| prime_factors(x) }.sort_by { |m| m.size }

# next, we simplify these factors removing duplicates, for example
# [2], [3, 2] becomes [], [3, 2]
primes.each_with_index do |v, i|
  puts primes.inspect
  next if v.empty?

  ((i + 1)...(primes.size)).each do |j|
    remove_each_from(primes[j], v)
  end
end


# finally, we flatten and multiply the remaining prime numbers
puts primes.flatten.inject(1) { |m, v| m * v }