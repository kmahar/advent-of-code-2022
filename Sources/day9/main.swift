import Utilities

enum Direction: String {
    case left = "L", right = "R", up = "U", down = "D"
}

struct Knot: Hashable {
    var x: Int
    var y: Int

    func isAdjacent(to other: Knot) -> Bool {
        (self.x-1...self.x+1).contains(other.x) && (self.y-1...self.y+1).contains(other.y)
    }

    mutating func moveCloser(to other: Knot) {
        if !self.isAdjacent(to: other) {
            if self.y > other.y {
                self.y -= 1
            } else if self.y < other.y {
                self.y += 1
            }

            if self.x < other.x {
                self.x += 1
            } else if self.x > other.x {
                self.x -= 1
            }
        }
    }
}

let data = try readLines(forDay: 9)
    .map { $0.split(separator: " ") }
    .map { (Direction(rawValue: String($0[0]))!, Int(String($0[1]))!) } 

func moveRope(knotCount: Int) -> Int {
    var knots = Array(repeating: Knot(x: 0, y: 0), count: knotCount)
    var tailVisited = Set<Knot>()
    for (direction, dist) in data {
        for _ in 1...dist {
            switch direction {
            case .left:
                knots[0].x -= 1
            case .right:
                knots[0].x += 1
            case .up:
                knots[0].y += 1
            case .down:
                knots[0].y -= 1
            }
            for i in 1..<knots.count {
                knots[i].moveCloser(to: knots[i-1])
            }
            tailVisited.insert(knots.last!)
        }
    }
    return tailVisited.count
}


print("Part 1: \(moveRope(knotCount: 2))")
print("Part 2: \(moveRope(knotCount: 10))")
