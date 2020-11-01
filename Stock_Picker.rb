def stock_picker(days)
    max_gain = [0,0]

    (0..days.length-1).each_with_index do |buy_index|
        days_after_buy = Array(buy_index..days.length - 1)

        days_after_buy.each do |sell_index|
            if(days[sell_index] - days[buy_index] > days[max_gain[1]] - days[max_gain[0]])
                max_gain = [buy_index, sell_index]
            end
        end
    end
    return max_gain
end

puts stock_picker([17,3,6,9,15,8,6,1,10])