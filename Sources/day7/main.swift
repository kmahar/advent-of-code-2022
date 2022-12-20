import Utilities

enum NodeType {
    case file(size: Int)
    case directory(contents: [String: Node])
}

class Node {
    var type: NodeType
    weak var parent: Node?

    init(type: NodeType, parent: Node?) {
        self.type = type
        self.parent = parent
    }

    func size() -> Int {
        switch self.type {
        case .file(let size):
            return size
        case .directory(let contents):
            return contents.values.map { $0.size() }.reduce(0, +)
        }
    }
}

let data = try Array(readLines(forDay: 7))
let root = Node(type: .directory(contents: [:]), parent: nil)

// current path we are at; should always be a directory node
var current = root
// whether we are currently processing ls output
var inLS = false

// parse all the output into a graph structure
for row in data {
    let parts = row.split(separator: " ")
    if parts[0] == "$" {
        inLS = false // starting a new command; if we were reading ls output we're done now
        switch parts[1] {
        case "cd":
            let newDir = String(parts[2])
            switch newDir {
            case "..":
                current = current.parent!
            case "/":
                current = root
            default:
                guard case let .directory(contents) = current.type else {
                    fatalError("current should always be a directory")
                }
                current = contents[newDir]!
            }
        case "ls":
            inLS = true
        default:
            fatalError("unexpected command \(parts[1])")
        }
    } else {
        assert(inLS, "got non-command output \(row) but was not processing ls output")
        guard case var .directory(contents) = current.type else {
            fatalError("current should always be a directory")
        }
        let name = String(parts[1])
        switch parts[0] {
        case "dir":
            contents[name] = Node(type: .directory(contents: [:]), parent: current)
        default:
            let size = Int(String(parts[0]))!
            contents[name] = Node(type: .file(size: size), parent: current)
        }
        current.type = .directory(contents: contents)
    }
}

// iteratively traverse root directory to find directories smaller than 100k
var part1 = 0
var nodesToVisit = [root]
while !nodesToVisit.isEmpty {
    var next = [Node]()
    for node in nodesToVisit {
        if case let .directory(contents) = node.type {
            if node.size() <= 100000 {
                part1 += node.size()
            }
            next += contents.values
        }
    }
    nodesToVisit = next
}
print("Part 1: \(part1)")

// iteratively traverse root directory to find directories which, when
// deleted, would leave us with at least 30_000_000 free
let rootSize = root.size()
var candidateSizes = [Int]()
nodesToVisit = [root]
while !nodesToVisit.isEmpty {
    var next = [Node]()
    for node in nodesToVisit {
        if case let .directory(contents) = node.type {
            let sizeWithout = rootSize - node.size()
            if sizeWithout <= 40_000_000 {
                candidateSizes.append(node.size())
            }
            next += contents.values
        }
    }
    nodesToVisit = next
}

// smallest possible directory to delete
print("Part 2: \(candidateSizes.min()!)")
