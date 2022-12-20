import Utilities

struct Crate {
    let label: Character
}

struct Move {
    let quantity: Int
    let start: Int
    let end: Int
}

let data = try readLines(forDay: 5, omittingEmptySubsequences: false).split(separator: "")
let numStacks = Int(data[0].last!.split(separator: " ").last!)!

// left to right pile of crates stored in bottom-to-top order
var crates: [[Crate]] = Array(repeating: [], count: numStacks)
for var row in data[0].dropLast() {
    for i in 0..<numStacks {
        let rawCrate = row.prefix(3)
        if i != numStacks - 1 {
            row.removeFirst(4)
        }
        if rawCrate == "   " {
            continue
        } else {
            let crate = Crate(label: rawCrate.dropFirst().first!)
            crates[i].insert(crate, at: 0)
        }
    }
}

let moves = data[1].map { row in
    // move x from y to z
    let splits = row.split(separator: " ")
    let quantity = Int(splits[1])!
    let start = Int(splits[3])!
    let end = Int(splits[5])!
    return Move(quantity: quantity, start: start, end: end)
}

func processCrateMoves(crates: [[Crate]], moves: [Move], oneAtATime: Bool) -> String {
    var crates = crates
    for move in moves {
        let cratesToMove = crates[move.start - 1].suffix(move.quantity)
        crates[move.start - 1].removeLast(move.quantity)
        if oneAtATime {
            crates[move.end - 1].append(contentsOf: cratesToMove.reversed())
        } else {
            crates[move.end - 1].append(contentsOf: cratesToMove)
        }
    }
    return crates.map { String($0.last!.label) }.joined()
}

print("Part 1: \(processCrateMoves(crates: crates, moves: moves, oneAtATime: true))")
print("Part 2: \(processCrateMoves(crates: crates, moves: moves, oneAtATime: false))")
