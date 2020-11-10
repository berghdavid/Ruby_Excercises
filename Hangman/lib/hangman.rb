require 'csv'

class Hangman
    attr_reader :word, :guessed_word, :attempts_left, :game_over, :wrongly_guessed

    def initialize()
        @attempts_left = 8
        @game_over = false
        @wrongly_guessed = []
    end

    def generate_word()
        dict_path = "dictionary.txt"

        if(File.exist? dict_path)
            lines = File.readlines dict_path
            @word = nil
            while(@word == nil)
                nr = rand(lines.length)
                new_word = lines[nr]
                if(new_word.length >= 5)
                    @word = new_word.capitalize!
                end
            end

            @guessed_word = ""
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
        output_guess = @guessed_word.gsub(/(.{1})(?=.)/, '\1 \2')

        while(!@game_over)
            puts "========================================================"
            puts "You have #{@attempts_left} attempts left."
            puts "You have guessed #{output_guess} so far."
            puts "Your wrongly guessed letters are #{wrongly_guessed}"
            puts "Guess a new letter..."
            input = gets.chomp.downcase
            guess_char(input)
        end
    end

    private def prompt_load_game()
        init_saved_game_folder
        
        #Puts list of all games
        list_of_names = []
        contents = CSV.open "saved_games.csv", headers: true, header_converters: :symbol
        puts "Which of the following games do you want to load?"

        contents.each do |row|
            name = row[:name]
            attempts_left = columns[:attempts_left]
            list_of_names += [name]
            puts "Name: #{name}, with #{attempts_left} attempts left."
        end
        
        while(true)
            input = gets
            if(list_of_names.include?(input))
                csv = CSV.read( "saved_games.csv", header: true )
                row = csv.find {|row| row["name"] == input}
                load_game(row)
                break
            else
                puts "Could not find game with name #{input}, try again."
            end
        end
    end

    private def load_game(row)
        puts row
        puts "Successfully loaded game DWAKODAK"
    end

    private def init_saved_game_folder
        if(!File.exist?("saved_games.csv"))
            CSV.open("file.csv", "wb") do |csv|
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

    def guess_char(char)
        if(is_char?(char))
            update_guess(char)
        else
            puts "Input is not a letter, try again."
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
            puts "Current progress: #{@guessed_word}"
            puts "Attempts left: #{@attempts_left}"
            if(won?)
                @game_over = true
                print "You won with #{@attempts_left} attempts left. The word was #{@word}"
            end
        else
            @attempts_left -= 1
            @wrongly_guessed += [char]
            puts "#{char} is an incorrect guess!"
            puts "Current progress: #{@guessed_word}"
            puts "Attempts left: #{@attempts_left}"
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

    public def is_char?(char)
        char.upcase != char.downcase && char.length == 1
    end
  
end

hm = Hangman.new()
hm.start_game