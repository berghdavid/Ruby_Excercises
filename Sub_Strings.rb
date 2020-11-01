def substrings(string, dictionary)
    matches = Hash.new(0)
    downcased = string.downcase

    dictionary.each do |dict_word|
        matches[dict_word] += downcased.scan(dict_word.downcase).length
    end
    return matches
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
string = "Howdy partner, sit down! How's it going?"
puts substrings(string, dictionary)