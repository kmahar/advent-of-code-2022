import Utilities

let data = try readLines(forDay: 8).map { Array($0).map { Int(String($0))! } }

let xMax = data[0].count - 1
let yMax = data.count - 1

var part1 = 0
for x in 0...xMax {
    for y in 0...yMax {
        // all trees on the edge are visible
        if x == 0 || y == 0 || x == xMax || y == yMax  {
            part1 += 1
            continue
        }

        let value = data[y][x]

        let treesToLeft = data[y].prefix(x)
        if treesToLeft.allSatisfy({ $0 < value }) {
            part1 += 1
            continue
        }
        let treesToRight = data[y].suffix(xMax - x)
        if treesToRight.allSatisfy({ $0 < value }) {
            part1 += 1
            continue
        }

        let treesAbove = (0..<y).map { data[$0][x] }
        if treesAbove.allSatisfy({ $0 < value }) {
            part1 += 1
            continue
        }

        let treesBelow = (y+1...yMax).map { data[$0][x] }
        if treesBelow.allSatisfy({ $0 < value }) {
            part1 += 1
            continue
        }
    }
}

print("Part 1: \(part1)")

var part2 = 0
for x in 0...xMax {
    for y in 0...yMax {
        // bordering trees will always have a scenic score of 0
        if x == 0 || y == 0 || x == xMax || y == yMax {
            continue
        }

        let value = data[y][x]

        // check trees to the left
        var leftScore = 0
        if x >= 1 {
            for neighborX in stride(from: x-1, through: 0, by: -1) {
                leftScore += 1
                if data[y][neighborX] >= value {
                    break
                }
            }
        }

        // check trees to the right
        var rightScore = 0
        if x < xMax {
            for neighborX in x+1...xMax {
                rightScore += 1
                if data[y][neighborX] >= value {
                    break
                }
            }
        }

        // check trees above
        var topScore = 0
        if y >= 1 {
            for neighborY in stride(from: y-1, through: 0, by: -1)  {
                topScore += 1
                if data[neighborY][x] >= value {
                    break
                }
            }
        }

        // check trees below
        var belowScore = 0
        if y < yMax {
            for neighborY in y+1...yMax {
                belowScore += 1
                if data[neighborY][x] >= value {
                    break
                }
            }
        }

        let score = rightScore * leftScore * topScore * belowScore
        if score > part2 {
            part2 = score
        }
    }
}

print("Part 2: \(part2)")
