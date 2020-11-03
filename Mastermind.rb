class Mastermind
    attr_reader :code

    def initialize
        @available_codes = {0 => "Red", 1 => "Blue", 2 => "Green", 3 => "White"}
        generateCode
        puts "Code generated..."
    end

    private def promptRounds
        while (true)
            puts "How many rounds do you want to play?"
            input = gets.chomp.strip
            input = Integer(gets.chomp.strip) rescue false
            if(input != 0)
                @rounds = input
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
puts game.code