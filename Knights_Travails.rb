class Chessboard
    def initialize
        @board = []
        for i in 1..8
            for j in 1..8
                @board.push([i,j])
            end
        end
    end

    def knight_moves(arr_from, arr_to)
        @from = arr_from
        @to = arr_to

        moves = possible_moves(arr_from)
    end

    def possible_moves(arr_from)
        moves = []
        for i in -2..2
            if(i != 0)
                if(Math.abs(i) == 1)
                    moves.push([arr_from[0] + i, arr_from[1] - 2])
                    moves.push([arr_from[0] + i, arr_from[1] + 2])
                elsif(Math.abs(i) == 2)
                    moves.push([arr_from[0] + i, arr_from[1] - 2])
                    moves.push([arr_from[0] + i, arr_from[1] + 2])
                end
            end
        end
    end

end


