text = File.readlines("input.in") # read the file into an array of strings
results = [0, 0]

text.each { |str|
    char_min = str.match(/[^-]*/).to_s.to_i # minimum times the character should appear (matches the string 
                                       # till the first "-" character and converts what it matched to an int)
    char_max = str.match(/[0-9]* [ ]*/).to_s.strip.to_i # maximum times the character should appear
    char_to_match = str.match(/[a-zA-Z]/).to_s # The character we're matching on
    password = str.match(/: ([a-zA-Z])+/).to_s[2..-1] # the actual password. this matches starting from the ": " part but trims the first 2 chars
    iterations = password.count(char_to_match) # How many times the character we're matching on actually appears in the pw

    if iterations >= char_min and iterations <= char_max then results[0] += 1 # check if the pw meets the criteria for task 1
    end

    if (password[char_min - 1] == char_to_match) != (password[char_max - 1] == char_to_match) # check if the pw meets the criteria for task 2
        results[1] += 1 
    end

    puts "Minimum: %s\tMaximum: %s\nChar: %s\tPw: %s\n\n" % [char_min, char_max, char_to_match, password]
}

puts "Number of passwords that meet the first criteria: %d" % [results[0]]
puts "Number of passwords that meet the second criteria: %d" % [results[1]]