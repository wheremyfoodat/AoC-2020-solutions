import Swift
import Foundation // required for exit

var nums: [Int] = []
var isTaskComplete = [false, false]

do {
    let path = "input.in"
    let file = try String(contentsOfFile: path) // read file as string
    let text = file.components(separatedBy: "\n") // split it on newlines

    for i in text {
        nums.append(Int(i) ?? 0) // number-ify the text
    }
} 

catch let error {
    print("Fatal Error: Unable to load file") // if the file failed to load, cry
}

for i in nums {
    for j in nums {
        if i + j == 2020, !isTaskComplete[0] {
            print("Product of 2 numbers whose sum is 2020: ", i * j) // once the 2 numbers are found, print their sum
            isTaskComplete[0] = true // mask task 0 as completed
            if isTaskComplete[1] { // early exit if both tasks are complete
                exit(0)
            }
        }
        
        for k in nums {
            if isTaskComplete[1] { // if the task has already been completed, skip the loop entirely
                break;
            }

            if i + j + k == 2020 { 
                print("Product of 3 numbers whose sum is 2020: ", i * j * k) // once the 2 numbers are found, print their sum
                isTaskComplete[1] = true // mark task 1 as completed
                if isTaskComplete[0] { // early exit if both tasks are complete
                    exit(0)
                }
            }
        }
    }
}