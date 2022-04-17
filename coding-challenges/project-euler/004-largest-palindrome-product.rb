require 'byebug'
require './algo'

# is the number a product of 2 3 digit number? (xxx * xxx)
def is_3_digit_product?(num)
  factors = prime_factors(num)
  splits = factors.size.div(2)
  indexes = (0...(factors.size)).to_a

  while splits > 0
    indexes.combination(splits).each do |combi|
      a = combi.map { |i| factors[i] }.inject(1) { |product, n| product * n }
      b = factors.each_with_index.find_all { |factor, index| !combi.include?(index) }.inject(1) { |product, n| product * n[0] }

      if a.to_s.size == 3 && b.to_s.size == 3
        return true
      end
    end

    splits -= 1
  end

  false
end

max_num = (999 * 999).to_s
mid = max_num.size.div(2)
puts mid
mid += 1 if max_num.size % 2 != 0
puts mid

half = max_num[0, mid]

num = half.to_i
next_pal = "#{num}#{num.to_s.reverse}".to_i
puts next_pal
while next_pal > 99 * 99
  if is_3_digit_product?(next_pal)
    puts next_pal
    exit 1
  end

  num -= 1
  next_pal = "#{num}#{num.to_s.reverse}".to_i
end

puts half