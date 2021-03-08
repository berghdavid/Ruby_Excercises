
def knight_moves(arr_from, arr_to)
    puts "Requested path from #{arr_from} to #{arr_to}."

    layer = -1
    start = Knight.new([arr_from])
    solution = [[]]

    while(!solution.include?(arr_to))
        layer += 1
        total_paths = start.get_moves_layer(layer)
        for path_ex in total_paths
            if(path_ex.include?(arr_to))
                solution = path_ex
                break
            end
        end
    end
     
    puts "You made it in #{layer} moves! Here's your path:"
    for square in solution
        puts "[#{square[0]},#{square[1]}]"
    end
end


class Knight
    def initialize(path)
        @path = path
        @next_knights = []
    end

    def init_next_knights()
        next_squares = possible_moves(@path[-1])
        for square in next_squares
            @next_knights += [Knight.new(@path + [square])]
        end
    end

    def get_moves_layer(layers_deep)
        if(layers_deep == 0)
            return [@path]
        end
        init_next_knights()
        total_paths = [[[]]]
        for kn in @next_knights
            total_paths |= kn.get_moves_layer(layers_deep-1)
        end
        return total_paths
    end

    def possible_moves(square)
        moves = []
        for i in -2..2
            if(i.abs == 1)
                moves.push([square[0] + i, square[1] - 2])
                moves.push([square[0] + i, square[1] + 2])
            elsif(i.abs == 2)
                moves.push([square[0] + i, square[1] - 1])
                moves.push([square[0] + i, square[1] + 1])
            end
        end
        moves.select {|square| !@path.include?(square) && inside_board?(square) }
        return moves
    end

    def inside_board?(square)
        x = square[0] > 0 && square[0] < 9
        y = square[1] > 0 && square[1] < 9
        return x && y
    end
end

knight_moves([0,0],[1,2])
knight_moves([0,0],[3,3])
knight_moves([3,3],[0,0])
