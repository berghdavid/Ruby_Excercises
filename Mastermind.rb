class mastermind
    attr_reader :code
    def initialize
        @available_codes = {0 => "Red", 1 => "Blue", 2 => "Green", 3 => "White"}
        generateCode
    end

    private def generateCode
        @code = []
        4.times { @code.push(rand(4)) }
    end
end

game = mastermind.new()
puts game.code