import Utilities

let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
var priorities = [Character: Int]()
for (i, char) in characters.enumerated() {
    priorities[char] = i + 1
}

let data = try readLines(forDay: 3)

var part1 = 0
for line in data {
    let sackSize = line.count / 2
    let firstSack = line.prefix(sackSize)
    let secondSack = line.suffix(sackSize)
    let sharedItem = Set(firstSack).intersection(Set(secondSack))
    assert(sharedItem.count == 1)
    part1 += priorities[sharedItem.first!]!
}
print("Part 1: \(part1)")

var part2 = 0
for i in stride(from: 0, to: data.count, by: 3) {
    let sharedItem = Set(data[i]).intersection(Set(data[i + 1])).intersection(Set(data[i + 2]))
    assert(sharedItem.count == 1)
    part2 += priorities[sharedItem.first!]!
}
print("Part 2: \(part2)")