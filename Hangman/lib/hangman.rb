require 'csv'

class Hangman
    attr_reader :word, :guessed_word, :attempts_left, :game_over, :wrongly_guessed

    def initialize()
        @attempts_left = 8
        @game_over = false
        @guessed_word = ""
        @wrongly_guessed = ""
    end

    def generate_word()
        dict_path = "dictionary.txt"

        if(File.exist? dict_path)
            lines = File.readlines dict_path
            @word = nil
            while(@word == nil)
                nr = rand(lines.length)
                new_word = lines[nr].chomp
                if(new_word.length >= 5)
                    @word = new_word.capitalize!
                end
            end

            @word.length.times { @guessed_word += "_"}

            if(@word != nil)
                puts "Word successfully generated!"
            else
                puts "Could not generate word..."
            end
        else
            puts "Cannot find file"
        end
    end

    public def start_game()
        if(prompt_new_game?)
            generate_word()
        else
            prompt_load_game
        end
        prompt_guesses
    end

    private def prompt_guesses
        while(!@game_over)
            output_guess = @guessed_word.gsub(/(.{1})(?=.)/, '\1 \2')
            puts "========================================================"
            puts "You have #{@attempts_left} attempts left."
            puts "You have guessed #{output_guess} right so far."
            puts "Your wrongly guessed letters are #{@wrongly_guessed}"
            puts "Guess a new letter, or type save to save this game"
            input = gets.chomp.downcase
            
            if(is_char?(input))
                update_guess(input)
            elsif(input == "save")
                save_game
                break
            else
                puts "Input is not a letter, try again."
            end
        end
    end

    public def is_char?(char)
        char.upcase != char.downcase && char.length == 1
    end

    private def save_game
        list_of_names = []
        contents = CSV.open "saved_games.csv", headers: true, header_converters: :symbol
        contents.each do |row|
            list_of_names += [row[:name]]
        end

        while(true)
            puts "Enter the name of this game"
            name = gets.chomp
            
            if(!list_of_names.include?(name) && name != "")
                data = [name, @word, @guessed_word, @attempts_left, @wrongly_guessed]
                CSV.open('saved_games.csv', 'a') do |row|
                    row << data
                end
                break
            else
                puts "Game-name occupied or invalid, try another one"
            end
        end
    end

    private def prompt_load_game()
        init_saved_game_folder
        
        #Puts list of all games
        list_of_names = []
        contents = CSV.open "saved_games.csv", headers: true, header_converters: :symbol
        
        contents.each do |row|
            name = row[:name]
            attempts_left = row[:attempts_left]
            guessed_word = row[:guessed_word]

            list_of_names += [name]
            
            puts "Name: #{name}, completed #{guessed_word} with #{attempts_left} attempts left."
        end

        if(!list_of_names.empty?)
            puts "Which of the above games do you want to load?"
            while(true)
                input = gets.chomp
                if(list_of_names.include?(input))
                    csv = CSV.read("saved_games.csv", headers: true, header_converters: :symbol)
                    row = csv.find {|row| row[:name] == input}
                    load_game(row)
                    break
                else
                    puts "Could not find game with name #{input}, try again."
                end
            end
        else
            puts "No available games to load..."
            start_game
        end
    end

    # Fix this method
    private def load_game(row)
        @word = row[:word]
        @guessed_word = row[:guessed_word]
        @attempts_left = row[:attempts_left]
        @wrongly_guessed = row[:wrongly_guessed]
        puts "Successfully loaded game #{row[:name]}"
        prompt_guesses
    end

    private def init_saved_game_folder
        if(!File.exist?("saved_games.csv"))
            CSV.open("saved_games.csv", "wb") do |csv|
                csv << ["name", "word", "guessed_word", "attempts_left", "wrongly_guessed"]
            end
        end
    end

    private def prompt_new_game?
        while(true)
            puts "Do you want to start a new game? (Y/N)"
            input = gets.chomp.downcase
            if(input == "y" || input == "yes")
                return true
                break
            elsif(input == "n" || input == "no")
                return false
                break
            else
                puts "Incorrect input, try again"
            end
        end
    end

    private def update_guess(char)
        contains_char = false

        @word.split("").each_with_index do |c, index|
            if(c.downcase == char)
                contains_char = true
                @guessed_word[index] = c
            end
        end

        if(contains_char)
            puts "#{char} is a correct guess!"
            if(won?)
                @game_over = true
                print "You won with #{@attempts_left} attempts left. The word was #{@word}\n"
            end
        else
            @attempts_left -= 1
            @wrongly_guessed += char
            puts "#{char} is an incorrect guess!"
            if(lost?)
                @game_over = true
                print "You lost. The word was #{@word}"
            end
        end
    end

    private def won?()
        return @guessed_word == @word
    end

    private def lost?()
        return @attempts_left <= 0
    end
end

hm = Hangman.new()
hm.start_game