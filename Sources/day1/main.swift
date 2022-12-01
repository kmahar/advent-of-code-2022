import Utilities

let data = try readLines(forDay: 1, omittingEmptySubsequences: false)
let dataSplitByElf = data.split(separator: "").map { $0.map { Int($0)! }.reduce(0, +) }
print("Part 1: \(dataSplitByElf.max()!)")

let sortedData = dataSplitByElf.sorted()
print("Part 2: \(sortedData.suffix(3).reduce(0, +))")