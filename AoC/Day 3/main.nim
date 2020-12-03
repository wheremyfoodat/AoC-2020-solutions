import strutils
import strformat

proc calcTreesWithSlope (maze: seq[string], width: int, height: int, slope_x: int, slope_y: int): int =
    var (x, y, trees) = (0, 0, 0)
    while y < height:
        while x < width:
            if y >= height:
                return trees

            if maze[y][x] == '#':
                trees += 1

            x += slope_x
            y += slope_y

        x -= width
    return trees

let file = readFile("input.in")
let maze = splitLines(file)

let (width, height) = (maze[0].len, len(maze))

let slopes_x = [1, 3, 5, 7, 1]
let slopes_y = [1, 1, 1, 1, 2] 
var results = [0, 0, 0, 0, 0]
var product = 1

for i in 0..4:
    results[i] = calcTreesWithSlope(maze, width, height, slopes_x[i], slopes_y[i])
    echo fmt "Slope {i+1}: Found {results[i]} trees!"
    product *= results[i]

echo fmt "Product of all results: {product}!"