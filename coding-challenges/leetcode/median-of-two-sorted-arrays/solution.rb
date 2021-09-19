require 'pry'
require 'byebug'

module MedianOfTwo
    def self.median(arr)
        if arr.empty?
            return 0
        end
        
        mid = arr.size / 2
        
        if arr.size.even?
            a = arr[mid - 1]
            b = arr[mid]
            
            return (a + b) / 2.0
        else
            return arr[mid]
        end
    end
    
    def genmedian(num, size = 10)
        left = (1..size).map { rand((num - 100)..(num - 1)) }
        right = (1..size).map { rand((num + 1)..(num + 100)) }
        
        (left + [num] + right).sort
    end
    
    
    def self.concat_median2(arr1, arr2)
        size = arr1.size + arr2.size
        
        i = j = size / 2
        
        if size.even?
            j = i - 1
        end
        
        a = i < arr1.size ? arr1[i] : arr2[i - arr1.size]
        b = j < arr1.size ? arr1[j] : arr2[j - arr1.size]
        
        return (a + b) / 2.0
    end
    
    def self.partition(arr)
        i = j = arr.size / 2
        
        if arr.size.even?
            j = i -1
        end
        
        left = arr[0...j]
        middle = arr[j..i]
        right = arr[(i+1)..-1]
        
        [left, middle, right]
    end
    
    def self.overlap_median2(arr1, arr2)
        # assert(arr1.size >= arr2.size)
        
        l1, m1, r1 = partition(arr1)
        l2, m2, r2 = partition(arr2)        
        
        if m1.first >= m2.last      
            left = -> { [l1.last, l2.last, m2.last].compact.max }
            right = -> { [r1.first, r2.first, m1.first].compact.min }
            
            if arr1.size.odd? == arr2.size.odd?
                return (left.call + right.call) / 2.0
            end
            
            if arr1.size.even? && arr2.size.odd?
                return right.call
            end
            
            if arr1.size.odd? && arr2.size.even?
                return left.call
            end
        elsif m1.last >= m2.first || m1.last >= m2.first
            # byebug   
            left = -> { [l1.last, l2.last, m1.first, m2.first].compact.max }
            right = -> { [r1.first, r2.first, m1.last, m2.last].compact.min }
            
            if arr1.size.odd? == arr2.size.odd?
                return (left.call + right.call) / 2.0
            end
            
            if arr1.size.even? && arr2.size.odd?
                return right.call
            end
            
            if arr1.size.odd? && arr2.size.even?
                return left.call
            end
        # elsif m1.first >= m2.last   
        #     # byebug   
        #     left = -> { [l1.last, l2.last, m1.first, m2.first].compact.max }
        #     right = -> { [r1.first, r2.first, m1.last, m2.last].compact.min }
            
        #     if arr1.size.odd? == arr2.size.odd?
        #         return (left.call + right.call) / 2.0
        #     end
            
        #     if arr1.size.even? && arr2.size.odd?
        #         return right.call
        #     end
            
        #     if arr1.size.odd? && arr2.size.even?
        #         return left.call
        #     end 
        else
            left = -> { [l1.last, l2.last, m1.last].compact.max }
            right = -> { [r1.first, r2.first, m2.first].compact.min }
            
            if arr1.size.odd? == arr2.size.odd?
                return (left.call + right.call) / 2.0
            end
            
            if arr1.size.even? && arr2.size.odd?
                return left.call
            end
            
            if arr1.size.odd? && arr2.size.even?
                return right.call
            end
            
        end
        
        return 0
        
    end
    
    def self.median2(arr1, arr2)
        # byebug
        
        m1 = median(arr1)
        m2 = median(arr2)
        
        if m1 == m2
            return m1
        end
        
        if arr1.empty?
            return median(arr2)
        end
        
        if arr2.empty?
            return median(arr1)
        end
        
        # arr1 > arr2
        if arr2.first >= arr1.last
            return concat_median2(arr1, arr2)
        elsif arr1.first >= arr2.last
            return concat_median2(arr2, arr1)
        end
        
        if arr1.size >= arr2.size
            return overlap_median2(arr1, arr2)
        else
            return overlap_median2(arr2, arr1)
        end
    end
end

def find_median_sorted_arrays(nums1, nums2)
    MedianOfTwo.median2(nums1, nums2)
end

