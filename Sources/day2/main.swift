import Utilities

enum RPS {
    case rock, paper, scissors

    init(_ s: Substring.SubSequence) {
        switch s {
        case "A":
            self = .rock
        case "B":
            self = .paper
        case "C":
            self = .scissors
        default:
            fatalError("Unrecognized RPS input \(s)")
        }
    }

    var score: Int {
        switch self {
        case .rock:
            return 1
        case .paper:
            return 2
        case .scissors:
            return 3
        }
    }

    func play(versus opponent: RPS) -> RPSResult {
        switch (self, opponent) {
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return .draw
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            return .lose
        case (.scissors, .paper), (.paper, .rock), (.rock, .scissors):
            return .win
        }
    }
}

enum RPSResult {
    case win, lose, draw

    init(_ s: Substring.SubSequence) {
        switch s {
        case "X":
            self = .lose
        case "Y":
            self = .draw
        case "Z":
            self = .win
        default:
            fatalError("Unrecognized RPS result \(s)")
        }
    }

    var score: Int {
        switch self {
        case .win:
            return 6
        case .lose:
            return 0
        case .draw:
            return 3
        }
    }
}

let data = try readLines(forDay: 2).map { $0.split(separator: " ") }

var part1Score = 0
for row in data {
    let opponent = RPS(row[0])
    let mine: RPS!
    switch row[1] {
    case "X":
        mine = .rock
    case "Y":
        mine = .paper
    case "Z":
        mine = .scissors
    default:
        fatalError("Unrecognized RPS value \(row[0])")
    }
    part1Score += mine.score + mine.play(versus: opponent).score
}
print("Part 1: \(part1Score)")

var part2Score = 0
for row in data {
    let opponent = RPS(row[0])
    let desiredOutcome = RPSResult(row[1])
    part2Score += desiredOutcome.score
    switch desiredOutcome {
    case .win:
        switch opponent {
        case .rock:
            part2Score += RPS.paper.score
        case .paper:
            part2Score += RPS.scissors.score
        case .scissors:
            part2Score += RPS.rock.score
        }
    case .lose:
        switch opponent {
        case .rock:
            part2Score += RPS.scissors.score
        case .paper:
            part2Score += RPS.rock.score
        case .scissors:
            part2Score += RPS.paper.score
        }
    case .draw:
        // play the same thing that opponent played
        part2Score += opponent.score
    }
}

print("Part 2: \(part2Score)")