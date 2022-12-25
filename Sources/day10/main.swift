import Utilities

enum Instruction {
    case noop
    case addx(Int)

    init(_ str: String) {
        if str == "noop" {
            self = .noop
        } else {
            let parts = str.split(separator: " ")
            assert(parts.count == 2)
            assert(parts[0] == "addx")
            self = .addx(Int(parts[1])!)
        }
    }
}

let data = try readLines(forDay: 10).map { Instruction(String($0)) }

var currentX = 1
var xValues = [1]
var remainingInstructions = Array(data)
var addXPending: Int? = nil


var crtPixels = [String]()
var crtPos = 0

for _ in 0..<240 {
    xValues.append(currentX)

    if (currentX-1...currentX+1).contains(crtPos) {
        crtPixels.append("#")
    } else {
        crtPixels.append(".")
    }

    crtPos += 1
    crtPos %= 40

    // wait until the "end" of the cycle to complete any pending addx instruction
    if let pending = addXPending {
        currentX += pending
        addXPending = nil
    } else {
        // queue up next addx instruction if applicable
        if case let .addx(amt) = remainingInstructions.removeFirst() {
            addXPending = amt
        }
    }
}

let part1 = 
    20 * xValues[20]
    + 60 * xValues[60]
    + 100 * xValues[100]
    + 140 * xValues[140]
    + 180 * xValues[180]
    + 220 * xValues[220]

print("Part 1: \(part1)")

print("Part 2:")
print(crtPixels[0..<40].joined())
print(crtPixels[40..<80].joined())
print(crtPixels[80..<120].joined())
print(crtPixels[120..<160].joined())
print(crtPixels[160..<200].joined())
print(crtPixels[200..<240].joined())
