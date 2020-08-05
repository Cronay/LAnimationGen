// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LAnimationGen",
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
        .testTarget(
            name: "LAnimationGenTests",
            dependencies: ["LAnimationGen"]),
    ]
)
