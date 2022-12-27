// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code-2022",
    targets: [
        .target(name: "Utilities"),
        .executableTarget(name: "day1", dependencies: ["Utilities"]),
        .executableTarget(name: "day2", dependencies: ["Utilities"]),
        .executableTarget(name: "day3", dependencies: ["Utilities"]),
        .executableTarget(name: "day4", dependencies: ["Utilities"]),
        .executableTarget(name: "day5", dependencies: ["Utilities"]),
        .executableTarget(name: "day6", dependencies: ["Utilities"]),
        .executableTarget(name: "day7", dependencies: ["Utilities"]),
        .executableTarget(name: "day8", dependencies: ["Utilities"]),
        .executableTarget(name: "day9", dependencies: ["Utilities"]),
        .executableTarget(name: "day10", dependencies: ["Utilities"]),
        .executableTarget(name: "day11", dependencies: ["Utilities"]),
    ]
)
