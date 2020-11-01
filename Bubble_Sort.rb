def bubble_sort(arr)
    index_popped = (0..arr.length-2)
    done = true

    until done do
        done = true
        index_popped.each do |index|
            if(arr[index] > arr[index + 1])
                arr[index], arr[index + 1] = arr[index + 1], arr[index]
                done = false
            end
        end
    end
    return arr
end

puts bubble_sort([4,3,78,2,0,2])