import Utilities

struct Monkey {
    var items: [Int]
    let operation: (Int) -> Int
    let modulo: Int
    let ifTestTrue: Int
    let ifTestFalse: Int
}

let monkey0 = Monkey(
    items: [62, 92, 50, 63, 62, 93, 73, 50],
    operation: { $0 * 7 },
    modulo: 2,
    ifTestTrue: 7,
    ifTestFalse: 1
)
let monkey1 = Monkey(
    items: [51, 97, 74, 84, 99],
    operation: { $0 + 3 },
    modulo: 7,
    ifTestTrue: 2,
    ifTestFalse: 4
)
let monkey2 = Monkey(
    items: [98, 86, 62, 76, 51, 81, 95],
    operation: { $0 + 4 },
    modulo: 13,
    ifTestTrue: 5,
    ifTestFalse: 4
)
let monkey3 = Monkey(
    items: [53, 95, 50, 85, 83, 72],
    operation: { $0 + 5 },
    modulo: 19,
    ifTestTrue: 6,
    ifTestFalse: 0
)
let monkey4 = Monkey(
    items: [59, 60, 63, 71],
    operation: { $0 * 5 },
    modulo: 11,
    ifTestTrue: 5,
    ifTestFalse: 3 
)
let monkey5 = Monkey(
    items: [92, 65],
    operation: { $0 * $0 },
    modulo: 5,
    ifTestTrue: 6,
    ifTestFalse: 3
)
let monkey6 = Monkey(
    items: [78],
    operation: { $0 + 8 },
    modulo: 3,
    ifTestTrue: 0,
    ifTestFalse: 7
)
let monkey7 = Monkey(
    items: [84, 93, 54],
    operation: { $0 + 1 },
    modulo: 17,
    ifTestTrue: 2,
    ifTestFalse: 1
)

var monkeys = [monkey0, monkey1, monkey2, monkey3, monkey4, monkey5, monkey6, monkey7]
var inspections = Array(repeating: 0, count: 8)

for _ in 1...20 {
    for i in 0..<monkeys.count {
        let monkey = monkeys[i]
        for item in  monkey.items {
            inspections[i] += 1
            let newLevel = monkey.operation(item) / 3
            if newLevel % monkey.modulo == 0 {
                monkeys[monkey.ifTestTrue].items.append(newLevel)
            } else {
                monkeys[monkey.ifTestFalse].items.append(newLevel)
            }
        }
        monkeys[i].items = []
    }
}

inspections.sort()
inspections.reverse()
print("Part 1: \(inspections[0] * inspections[1])")

monkeys = [monkey0, monkey1, monkey2, monkey3, monkey4, monkey5, monkey6, monkey7]
inspections = Array(repeating: 0, count: 8)

// since all the test numbers are prime we can just multiply them
// to find their least common multipe.
let leastCommonMultiple = monkeys.map { $0.modulo }.reduce(1, *)

for _ in 1...10_000 {
    for i in 0..<monkeys.count {
        let monkey = monkeys[i]
        for item in monkey.items {
            inspections[i] += 1
            // we don't care about the actual values of the items, we
            // only care whether the items pass the test. dividing
            // by the least common multiple will never affect which
            // tests a number passes, so we can safely use this to
            // keep the stores values small and prevent overflow.
            let newLevel = monkey.operation(item) % leastCommonMultiple
            if newLevel % monkey.modulo == 0 {
                monkeys[monkey.ifTestTrue].items.append(newLevel)
            } else {
                monkeys[monkey.ifTestFalse].items.append(newLevel)
            }
        }
        monkeys[i].items = []
    }
}

inspections.sort()
inspections.reverse()
print("Part 2: \(inspections[0] * inspections[1])")
