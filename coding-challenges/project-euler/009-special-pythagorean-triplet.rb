

(1..500).each do |a|
  (1..500).each do |b|
    c = Math.sqrt(a ** 2 + b ** 2)
    next unless c % 1 == 0

    if a + b + c == 1000
      puts(a * b * c)
      exit 0
    end
  end
end

exit 1