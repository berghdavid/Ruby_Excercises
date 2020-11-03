class Mastermind
    attr_reader :code, :rounds, :curr_round, :available_codes, :available_colors

    def initialize
        @int_to_color = {0 => "red", 1 => "blue", 2 => "green", 3 => "orange", 4 => "yellow", 5 => "pink"}
        @available_colors = ["red", "blue", "green", "orange", "yellow", "pink"]
        generateCode
        puts "Code generated..."
        @curr_round = 1
        @playerScore = 0
        @compScore = 0
        @attempts = 0
        promptRounds
    end

    public def startGame
        while(curr_round <= rounds)
            puts "Round #{curr_round}:"
            while(true)
                input = promptInput
                rightInputs = compare(input)
                puts "There were #{rightInputs[0]} correct colors AND positions,"
                puts "and #{rightInputs[1]} remaining correct colors but in the wrong places."

                if(rightInputs[0] == 4)
                    @playerScore += 1
                    @curr_round += 1
                    displayScore
                    break
                elsif(@attempts == 8)
                    @compScore += 1
                    attempts = 0
                    @curr_round += 1
                    displayScore
                    break
                end
                @attempts += 1
            end
        end
        displayWinner
    end

    private def displayWinner
        if(@playerScore > @compScore)
            puts "You win!"
        elsif(@playerScore < @compScore)
            puts "Computer wins!"
        else
            puts "Tie!"
        end
    end

    private def displayScore
        puts "Score:"
        puts "Player: #{@playerScore}"
        puts "Computer: #{@compScore}"
    end

    public def promptInput
        while (true)
            puts "Enter your guess of colors:"
            input = gets.chomp.strip.split(" ")
            input.each { |word| word.downcase }

            inputIsColors = input.all? { |word| @available_colors.include?(word) }
            if(inputIsColors && input.size == 4)
                return input
                break
            else
                puts "Invalid input..."
            end
        end
    end

    private def compare(inputArray)
        correct_color = 0
        correct_color_and_place = 0
        incorrectly_guessed = Array.new(4, nil)
        missing_code = Array.new(4, nil)

        inputArray.each_with_index do |color, index|
            if(color == @code[index])
                correct_color_and_place += 1
            else
                incorrectly_guessed[index] = color
                missing_code[index] = @code[index]
            end
        end

        incorrectly_guessed.each_with_index do |color, index|
            if(color != nil && missing_code.include?(color))
                correct_color += 1
                missing_code.delete_at(missing_code.find_index(color))
            end
        end

        return [correct_color_and_place, correct_color]
        return "There were #{correct_color_and_place} correct colors AND positions,
        and #{correct_color} remaining correct colors but in the wrong places."
    end

    private def promptRounds
        while (true)
            puts "How many rounds do you want to play?"
            input = Integer(gets.chomp.strip) rescue false
            if(input != 0)
                @rounds = input
                puts "#{@rounds} rounds selected..."
                break;
            else
                puts "Invalid input"
            end
        end
    end

    private def generateCode
        @code = []
        4.times { @code.push(@int_to_color[rand(6)]) }
    end
end

game = Mastermind.new
game.startGame