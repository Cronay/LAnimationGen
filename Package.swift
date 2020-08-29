// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LAnimationGen",
    products: [
        .library(name: "LAnimationGen", targets: ["LAnimationGen"]),
        .executable(name: "LAnimationGen-CLI", targets: ["LAnimationGenCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
    ],
    targets: [
        .target(
            name: "LAnimationGen",
            dependencies: [
                .product(name: "ArgumentParser",
                         package: "swift-argument-parser")
            ]),
        .target(
            name: "LAnimationGenCLI",
            dependencies: [
                "LAnimationGen"
            ]),
        .testTarget(
            name: "LAnimationGenTests",
            dependencies: ["LAnimationGen",]),
    ]
)
