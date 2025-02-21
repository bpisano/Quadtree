// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Quadtree",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .macCatalyst(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "Quadtree",
            targets: ["Quadtree"]
        ),
    ],
    targets: [
        .target(name: "Quadtree"),
        .testTarget(
            name: "QuadtreeTests",
            dependencies: ["Quadtree"]
        ),
    ]
)
