// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code-2022",
    targets: [
        .target(name: "Utilities"),
        .executableTarget(name: "day1", dependencies: ["Utilities"]),
    ]
)
