// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TimerTechTaskPackage",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "TimerTechTaskPackage", targets: ["TimerTechTaskPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "3.1.8"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.1")
    ],
    targets: [
        .target(
            name: "TimerTechTaskPackage",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios"),
                "SnapKit"
            ],
            path: "Sources/TimerTechTaskPackage",
            resources: [.process("Resources")]
        ),
    ]
)
