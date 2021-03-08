class Caesar
    def caesar_cipher(string = "What a string!", shift = 5)
        upcase_first = "A".ord
        lowcase_first = "a".ord
        chars = "z".ord- "a".ord + 1
        caesar_string = ""

        string.each_char do |char|
            if char =~ /[a-z]/
                shifted = (((char.ord - lowcase_first + shift) % chars) + lowcase_first).chr
                caesar_string += shifted
            elsif char =~ /[A-Z]/
                shifted = (((char.ord - upcase_first + shift) % chars) + upcase_first).chr
                caesar_string += shifted
            else
                caesar_string += char
            end
        end

        return caesar_string
    end
end

c = Caesar.new
puts c.caesar_cipher()