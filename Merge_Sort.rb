def merge_sort(array)
    if(array.length > 2)
        splitter = array.length/2
        arr1 = merge_sort(array[0..splitter])
        arr2 = merge_sort(array[splitter+1..array.length])
        
        newArray = []
        while(!arr1.empty? || !arr2.empty?)
            if(arr1.empty?)
                newArray.push(arr2.shift)
            elsif(arr2.empty? || arr1[0] < arr2[0])
                newArray.push(arr1.shift)
            else
                newArray.push(arr2.shift)
            end
        end
        return newArray
    elsif(array.length == 2 && array[0] > array[1])
        temp = array[0]
        array[0] = array[1]
        array[1] = temp
    end
    return array
end

b = [2,1]
a = [6,4,2,7,3,1,5]

puts merge_sort(a)