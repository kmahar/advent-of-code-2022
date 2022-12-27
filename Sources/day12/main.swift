import Utilities

let data = try readLines(forDay: 12)
let yMax = data.count
let xMax = data[0].count

struct Point: Hashable {
    let x: Int
    let y: Int

    var neighbors: [Point] {
        var result = [Point]()
        if self.x > 0 {
            result.append(Point(x: self.x-1, y: self.y))
        }
        if self.x < xMax - 1 {
            result.append(Point(x: self.x + 1, y: self.y))
        }
        if self.y > 0 {
            result.append(Point(x: self.x, y: self.y - 1))
        }
        if self.y < yMax - 1 {
            result.append(Point(x: self.x, y: self.y + 1))
        }
        return result
    }
}

var elevations: [Point: UInt8] = [:]

var start: Point!
var end: Point!
for (y, line) in data.enumerated() {
    for (x, char) in line.enumerated() {
        let point = Point(x: x, y: y)
        switch char {
        case "S":
            start = point
            elevations[point] = Character("a").asciiValue!
        case "E":
            end = point
            elevations[point] = Character("z").asciiValue!
        default:
            elevations[point] = char.asciiValue!
        }
    }
}

func doBFS(start: Point) -> Int? {
    var visited = Set<Point>()
    visited.insert(start)
    var candidatePaths: [[Point]] = [[start]]
    while !candidatePaths.isEmpty {
        var newCandidates = [[Point]]()
        for path in candidatePaths {
            for neighbor in path.last!.neighbors where !visited.contains(neighbor) 
                && Int(exactly: elevations[neighbor]!)! - Int(exactly: elevations[path.last!]!)! <= 1 {
                if neighbor == end {
                    return path.count
                }
                newCandidates.append(path + [neighbor])
                visited.insert(neighbor)
            }
        }
        candidatePaths = newCandidates
    }
    return nil
}

print("Part 1: \(doBFS(start: start)!)")

let minPathLength = elevations.filter { (point, elevation) in
    elevation == Character("a").asciiValue!
}.compactMap { (point, _) in
    doBFS(start: point)
}.min()!

print("Part 2: \(minPathLength)")
