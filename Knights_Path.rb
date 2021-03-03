X = 0
Y = 1

class Board
    attr_accessor x: y: x_to: y_to:

    def initialize()
        @x = 0
        @y = 0
        @x_to = 0
        @y_to = 0
    end

    def knight_moves(from, to)
        recursive_moves([from], to)
    end

    def move_knight(to)
        if(to[X] < 0 || to[X] > 7 || to[Y] < 0 || to[T] > 7)
            puts "Impossible move! Try again..."
            return false
        else
            puts "Successfully moved to [#{@to[X]}, #{@to[Y]}]!"
            return true
        end
    end
end

