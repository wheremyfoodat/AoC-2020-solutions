// This language is a joke.
package main
import (
    "fmt"
    "strings"
    "io/ioutil"
    "regexp"
    "strconv"
)

func verifyHeight(s string) bool {
    unit := s[len(s)-2:]
    height, _ := strconv.Atoi(string(s[:len(s)-2]))

    if unit == "cm" {
        return height >= 150 && height <= 193
    } else if unit == "in"{
        return height >= 59 && height <= 76
    }
    return false
}

func main() {
    file, err := ioutil.ReadFile("input.in")
    if err != nil {
        fmt.Print("Can't read input file")
    }

    lines := strings.Split(string(file), "\n\n") // Split the file into an array of passports
    results := [...] int {0, 0}
    isPPValid := [...] bool {false, false}

    requiredFields := [...] string { // fields that have to be in the passport
        "ecl", "pid", "eyr", "hcl",
        "byr", "iyr", "hgt",
    }

    eyr_finder := regexp.MustCompile(`(eyr:)[0-9]*`)
    iyr_finder := regexp.MustCompile(`(iyr:)[0-9]*`)
    byr_finder := regexp.MustCompile(`(byr:)[0-9]*`)
    hgt_finder := regexp.MustCompile(`(hgt:)[0-9]*[a-z]*`)
    hcl_finder := regexp.MustCompile(`(hcl:#)[0-9a-z]*`)
    ecl_finder := regexp.MustCompile(`(ecl:)[a-z]*`)
    pid_finder := regexp.MustCompile(`(pid:)[0-9]*`)

    for _, passport := range lines {
        isPPValid = [...] bool {true, true}
        
        for _, field := range requiredFields {
            if !strings.Contains(passport, field) {
                isPPValid = [...] bool {false, false}
                break
            }
        }

        if isPPValid[0] {
            results[0]++
        } else {
            continue
        }

        shit1 := eyr_finder.FindAllString(passport, 1)
        shit2 := iyr_finder.FindAllString(passport, 1)
        shit3 := byr_finder.FindAllString(passport, 1)
        shit4 := hgt_finder.FindAllString(passport, 1)
        shit5 := hcl_finder.FindAllString(passport, 1)
        shit6 := ecl_finder.FindAllString(passport, 1)
        shit7 := pid_finder.FindAllString(passport, 1)

        if shit1 == nil || shit2 == nil || shit3 == nil || shit4 == nil || shit5 == nil || shit6 == nil || shit7 == nil {
            continue
        }

        eyr, _ := strconv.Atoi(shit1[0][4:])
        iyr, _ := strconv.Atoi(shit2[0][4:])
        byr, _ := strconv.Atoi(shit3[0][4:])
        hgt := shit4[0][4:]
        hcl := shit5[0][5:]
        ecl := shit6[0][4:]
        pid := shit7[0][4:]

        isPPValid[1] = byr >= 1920 && byr <= 2002 &&
                       len(hcl) == 6 &&
                       eyr >= 2020 && eyr <= 2030 &&
                       iyr >= 2010 && iyr <= 2020 &&
                       len(pid) == 9 &&
                       (ecl == "amb" || ecl == "brn" ||ecl == "blu" || ecl == "gry" || ecl == "grn" || ecl == "hzl" || ecl == "oth") &&
                       verifyHeight(hgt)

        if isPPValid[1] {
            results[1]++
        }

        fmt.Printf("%s\neyr: %d byr: %d\niyr: %d\necl: %s pid: %s\nhcl: %s\n", passport, eyr, byr, iyr, ecl, pid, hcl)
    }

    fmt.Print(results[0], "\n", results[1])
}