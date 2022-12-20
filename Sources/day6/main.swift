import Utilities

let data = try Array(readLines(forDay: 6)[0])

for i in 0..<data.count - 4 {
    if Set(data[i..<i + 4]).count == 4 {
        print("Part 1: \(i + 4)")
        break
    }
}

for i in 0..<data.count - 14 {
    if Set(data[i..<i + 14]).count == 14 {
        print("Part 2: \(i + 14)")
        break
    }
}
