class Tictactoe
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @player_symbols = {"X" => @player1, "O" => @player2}

        arr = Array.new(3, " ")
        @board = [arr.clone, arr.clone, arr.clone]
        puts "Board initialized:"
        printBoard

        puts "Players #{@player1} (X) and #{@player2} (O)"
        puts "------------------------------------------"

        if(rand(2) == 0)
            @player_turn = @player1
            puts "Computer determines that #{@player1} goes first!"
        else
            @player_turn = @player2
            puts "Computer determines that #{@player2} goes first!"
        end
        printInstructions
    end

    private def printInstructions
        puts "Type your turn like this:"
        puts "3 3"
        puts "Which puts your symbol in the bottom right corner."
        puts "------------------------------------------"
    end

    public def runProgram
        while(true)
            puts "Type your turn, #{@player_turn}"
            input = gets.chomp.strip
            row = input[0].to_i
            col = input[2].to_i
            if(input.length == 3 && (1..3).include?(row) && (1..3).include?(col))
                square = [row - 1, col - 1]
                if(@board[square[0]][square[1]] == " ")
                    placeBrick(square)
                    printBoard
                    if(gameWon? != nil)
                        winner = @player_symbols[gameWon?]
                        puts "Winner is #{winner}!!"
                        break
                    end
                else
                    puts "Square is occupied, try again"
                end
            else
                printInstructions
            end
        end
    end

    private def placeBrick(position)
        if(@player_turn == @player1)
            @board[position[0]][position[1]] = "X"
            @player_turn = @player2
        else
            @board[position[0]][position[1]] = "O"
            @player_turn = @player1
        end
    end

    private def gameWon?
        lines.each do |line|
            if(winningLine?(line))
                return @board[line[0][0]][line[0][1]]
            end
        end
        return nil
    end

    private def winningLine?(line)
        lineSquares = []
        line.each do |square|
            lineSquares.concat([@board[square[0]][square[1]]])
        end
        return lineSquares[0] != " " && lineSquares.uniq.size <= 1
    end

    private def lines
        lines = []
        tempList = []
        tempList2 = []

        (0..2).each do |row|
            (0..2).each do |col|
                tempList.push([row, col])
                tempList2.push([col, row])
            end
            lines.concat([tempList.clone])
            lines.concat([tempList2.clone])
            
            tempList.clear
            tempList2.clear
        end
        diags = [[[0, 0],[1, 1],[2, 2]],[[2, 0],[1, 1],[0, 2]]]
        lines.concat(diags)
    end

    private def printBoard
        puts "-------------"
        @board.each do |row|
            print "|"
            row.each do |element|
                print " #{element} |"
            end
            puts "\n-------------"
        end
    end
end

game = Tictactoe.new("David", "Minette")
game.runProgram()