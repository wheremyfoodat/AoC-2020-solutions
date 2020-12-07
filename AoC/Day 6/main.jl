file = (read("input.in", String)) # read the file into a string
groups = split(file, "\n\n") # split it into an array where each field is the votes of a group
sum1 = 0 # result of task 1
sum2 = 0 # result of task 2
i = 1 # loop index

for x in groups # task 1 loop
    global sum1
    groupVotes = (replace(x, "\n" => "")) # eliminate newlines
    sum1 += size(unique(split(groupVotes, "")), 1) # split the votes into a character array, keep the unique characters, then add the number of unique chars to the sum
end

for x in groups # task 2 loop
    global sum2
    global i
    i = 1 # reset loop counter
    individualVotes = split(x, "\n") # split the group votes into an array where each field is the votes of each individual
    voteIntersection = individualVotes[1] # initialize the intersection

    if size(individualVotes, 1) == 1 # case where only 1 person answer
        sum2 += sizeof(individualVotes[1]) # add the amount of letters in the answer to the sum
        continue # continue to next iteration
    end

    while i < size(individualVotes, 1) # intersect the votes of each individual with the next's
        global i
        voteIntersection = intersect(voteIntersection, individualVotes[i + 1]) # intersect the votes with the votes of the next dude
        i += 1
    end

    sum2 += size(voteIntersection, 1) # add the number of shared votes to the sum
end


print("[Task 1] Sum: ", sum1, "\n")
print("[Task 2] Sum: ", sum2, "\n")