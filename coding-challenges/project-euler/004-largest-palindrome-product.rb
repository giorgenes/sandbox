def combinations(n, r)
  c = Array.new(r, 0)

  yield c

  # stop when c = [n - 1, n - 1, ..., n - 1]
  i = r - 1
  while !c.all? { |el| el == n - 1 }
  end
end

def is_pal?(num)
  num.to_s == num.to_s.reverse
end

(0..999).to_a.repeated_combination(2).each do |c|
  a, b = c

  a = 999 - a
  b = 999 - b

  if is_pal?(a * b)
    puts a, b
    puts a * b
    exit 0
  end
end