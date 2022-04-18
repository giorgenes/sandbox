a = (1..100).map { |x| x ** 2 }.sum
b = (1..100).sum ** 2

puts(b - a)