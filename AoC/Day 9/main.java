// <3 Java
import java.util.Scanner; 
import java.io.File;
import java.io.FileNotFoundException;

class Main {
  public static void main(String[] args) {

    var file = new File("input.in");
    var numbers = new long [(int) file.length()];
    long task1Answer = 0;
    
    try {
        var scanner = new Scanner(file);
        for (var i = 0; scanner.hasNextLong(); i++) {
            numbers[i] = scanner.nextLong();
        }
    }

    catch (FileNotFoundException e) {
        System.out.println("Bruh why is the compiler forcing me to add error handling");
    }

    for (var i = 25; i < numbers.length; i++) { // find the answer for part 1
        var pass = false;
        for (var j = i - 25; j < i; j++) {
            for (var k = i - 25; k < i; k++) {
                if (numbers[i] == numbers[j] + numbers[k]) {
                    pass = true;
                }
            }
        }

        if (!pass) {
            task1Answer = numbers[i];
            System.out.printf("[Task 1] Answer is %d\n", task1Answer);
            break;
        }
    }

    // i is the start of the contiguous set
    for (var i = 0; i < numbers.length; i++) { // task 2
        long sum = 0;
        long max = 0;
        long min = task1Answer;

        for (var j = i; sum < task1Answer; j++) {
            sum += numbers[j];
            min = numbers[j] < min ? numbers[j] : min;
            max = numbers[j] > max ? numbers[j] : max;
        }

        if (sum == task1Answer) {
            System.out.printf("[Task 2] Answer is (%d + %d) = %d", min, max, min + max);
            break;
        }
    }
  }
}