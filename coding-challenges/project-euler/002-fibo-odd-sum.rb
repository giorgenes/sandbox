



def fibo(max_term)
  a = 1
  b = 1

  return if max_term < 1

  yield 1

  while b < max_term
    c = a + b
    a = b
    b = c

    yield c
  end
end


sum = 0
fibo(4000000) do |term|
  if term % 2 == 0
    sum += term
  end
end

puts sum