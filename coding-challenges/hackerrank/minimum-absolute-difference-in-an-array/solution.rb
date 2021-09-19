#!/usr/bin/env ruby

require 'json'
require 'stringio'

#
# Complete the 'minimumAbsoluteDifference' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY arr as parameter.
#

def minimumAbsoluteDifference(arr)
    min = [Float::INFINITY, Float::INFINITY]
    minAbs = Float::INFINITY
    prev = minAbs
    
    arr.sort.each do |x|
        abs = (x - prev).abs
        if abs < minAbs
            minAbs = abs
        end
        prev = x
    end
        
    # Write your code here
    minAbs
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w') rescue STDOUT

_n = gets.strip.to_i

arr = gets.rstrip.split.map(&:to_i)

count = Hash.new(0)
arr.each_with_index do |v, i|
    count[v] += 1
    if count[v] > 1
        puts "#{v} at #{i}"
    end
end

result = minimumAbsoluteDifference arr

fptr.write result
fptr.write "\n"

fptr.close()
