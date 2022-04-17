
# https://en.wikipedia.org/wiki/Primality_test#C#,_C++_&_C
def efficient_is_prime?(n)
  if n == 2 || n == 3
    return true
  end

  # remember 1 isnt a prime: https://blogs.scientificamerican.com/roots-of-unity/why-isnt-1-a-prime-number/
  if n <= 1 || n % 2 == 0 || n % 3 == 0
    return false
  end

  i = 5
  while i * i <= n
    if n % i == 0 || n % (i + 2) == 0
      return false
    end

    i += 6
  end

  true
end

def is_prime?(n)
  efficient_is_prime?(n)
end

def find_first_divisable(n)
  i = 2
  while i <= n
    if n % i == 0
      return i
    end

    i += 1
  end

  raise "should never get here"
end

# https://www.bbc.co.uk/bitesize/guides/z9hb97h/revision/4#:~:text=Prime%20factors%20are%20factors%20of,use%20a%20prime%20factor%20tree.
def prime_factors(x)
  return [] if x <= 1

  q = [x]
  results = []

  while q.any?
    num = q.pop

    if is_prime?(num)
      results << num
    else
      divide_by = find_first_divisable(num)
      q << divide_by
      q << num / divide_by
    end
  end

  results
end

def is_pal?(num)
  num.to_s == num.to_s.reverse
end
