class Mastermind
    attr_reader :code :rounds :curr_round

    def initialize
        @available_codes = {0 => "Red", 1 => "Blue", 2 => "Green", 3 => "White"}
        generateCode
        puts "Code generated..."
        promptRounds
    end

    public def startGame
        puts "Round #{curr_round}:"
        puts "Enter the colors which you think is the code:"
        input = gets.chomp.strip.split(" ")
        puts input
    end

    private def promptRounds
        while (true)
            puts "How many rounds do you want to play?"
            input = Integer(gets.chomp.strip) rescue false
            if(input != 0)
                @rounds = input
                @curr_round = 0
                puts "#{@rounds} rounds selected..."
                break;
            else
                puts "Invalid input"
            end
        end
    end

    private def generateCode
        @code = []
        4.times { @code.push(rand(4)) }
    end
end

game = Mastermind.new
game.startGame