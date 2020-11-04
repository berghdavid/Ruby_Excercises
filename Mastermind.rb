class Mastermind
    def initialize
        @int_to_color = {0 => "red", 1 => "blue", 2 => "green", 3 => "orange", 4 => "yellow", 5 => "pink"}
        @available_colors = ["red", "blue", "green", "orange", "yellow", "pink"]
        @curr_round = 1
        @playerScore = 0
        @compScore = 0
        @attempts = 0
        @code = []
        @compClues = Array.new(4, nil)
        @possible_attempts = 8

        determineCodebreaker
        promptRounds
        promptAttempts
    end

    public def startGame
        while(@curr_round <= @rounds)
            puts "Round #{@curr_round} of #{@rounds}:"
            generateCode
            while(true)
                attempts_left = @possible_attempts - @attempts
                puts "You have #{attempts_left} attempts left!"

                if(@player_is_codebreaker)
                    input = playerPromptInput
                else
                    input = compGenerateInput
                    puts "Your hidden code was #{@code}"
                end

                right_answers = compare(input)
                correct_color_and_place = right_answers[0]
                correct_color = right_answers[1]

                puts "There were #{correct_color_and_place} correct colors AND positions,"
                puts "and #{correct_color} remaining correct colors but in the wrong places."
                puts "--------------------------------------"

                @attempts += 1
                if(correct_color_and_place == 4)
                    if(@player_is_codebreaker)
                        @playerScore += 1
                    else
                        @compScore += 1
                    end
                    @curr_round += 1
                    displayScore
                    break
                elsif(@attempts == @possible_attempts)
                    puts "Wrong! The correct code was #{@code}"
                    if(@player_is_codebreaker)
                        @compScore += 1
                    else
                        @playerScore += 1
                    end
                    @attempts = 0
                    @curr_round += 1
                    displayScore
                    break
                end
            end
        end
        displayWinner
    end

    private def generateCode
        if(!@player_is_codebreaker)
            puts "You are codemaker, make your code for the computer to break"
            @code = playerPromptInput
        else
            @code.clear
            4.times { @code.push(@int_to_color[rand(6)]) }
        end
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
        puts "========Score========"
        puts "Player: #{@playerScore}"
        puts "Computer: #{@compScore}"
        puts "====================="
    end

    public def playerPromptInput
        while (true)
            puts "The available colors are #{@available_colors}"
            puts "Enter your colors:"
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

    public def compGenerateInput
        compGuess = []
        4.times { compGuess.push(@int_to_color[rand(6)]) }

        @compClues.each_with_index do |color, index|
            if(color != nil)
                compGuess[index] = color
            end
        end
        puts "--------------------------------------"
        puts "Computer guesses colors #{compGuess}:"
        return compGuess
    end

    private def compare(inputArray)
        correct_color = 0
        correct_color_and_place = 0
        incorrectly_guessed = Array.new(4, nil)
        missing_code = Array.new(4, nil)

        inputArray.each_with_index do |color, index|
            if(color == @code[index])
                correct_color_and_place += 1
                @compClues[index] = color
            else
                incorrectly_guessed[index] = color
                missing_code[index] = @code[index]
            end
        end

        incorrectly_guessed.each_with_index do |color, index|
            if(color != nil && missing_code.include?(color))
                correct_color += 1
                index_of_color = missing_code.find_index(color)
                
                @compClues[index_of_color] = color
                missing_code.delete_at(index_of_color)
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
            if(input != 0 && input.even?)
                @rounds = input
                puts "#{@rounds} rounds selected..."
                break;
            else
                puts "Amount of rounds must be an even number"
            end
        end
    end

    private def promptAttempts
        while (true)
            puts "How many guesses for each code should be allowed? (Standard is 8)"
            input = Integer(gets.chomp.strip) rescue false
            if(input != 0)
                @possible_attempts = input
                puts "#{@possible_attempts} guesses selected..."
                break;
            else
                puts "Invalid input"
            end
        end
    end


    private def determineCodebreaker
        while (true)
            puts "Do you want to play codebreaker or codebreaker?"
            puts "1: codebreaker"
            puts "2: codemaker"
            input = gets.chomp.strip
            if(input == "1" || input == "codebreaker")
                @player_is_codebreaker = true
                break
            elsif(input == "2" || input == "codemaker")
                @player_is_codebreaker = false
                break
            else
                puts "Invalid input"
            end
        end
    end
end

game = Mastermind.new
game.startGame