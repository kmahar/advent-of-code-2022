import Utilities

let data = try readLines(forDay: 4)

var part1 = 0
var part2 = 0

for row in data {
    let split = row.split(separator: ",")
    let elf1Raw = split[0].split(separator: "-")
    let range1 = Int(elf1Raw[0])!...Int(elf1Raw[1])!
    let elf2Raw = split[1].split(separator: "-")
    let range2 = Int(elf2Raw[0])!...Int(elf2Raw[1])!

    if range1.contains(range2.lowerBound) && range1.contains(range2.upperBound) ||
        range2.contains(range1.lowerBound) && range2.contains(range1.upperBound) {
        part1 += 1
    }

    if range1.contains(range2.lowerBound) || range1.contains(range2.upperBound) ||
        range2.contains(range1.lowerBound) || range2.contains(range1.upperBound) {
        part2 += 1
    }
}
print("Part 1: \(part1)")
print("Part 2: \(part2)")
