require './algo'

triangle_numbers(1_000_000).each do |x|
  if enum_divisibles(x).sort.uniq.size > 500
    puts x
    exit 0
  end
end 

exit 1