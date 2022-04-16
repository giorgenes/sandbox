
def multiples_of(xs, n)
  (1..n).each do |i|
    if xs.any? { |x| i % x == 0 }
      yield i
    end
  end
end


sum = 0

multiples_of([3, 5], 999) do |mul|
  sum += mul
end

puts sum