// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuadTree",
    products: [
        .library(
            name: "QuadTree",
            targets: ["QuadTree"]
        ),
    ],
    targets: [
        .target(name: "QuadTree"),
        .testTarget(
            name: "QuadTreeTests",
            dependencies: ["QuadTree"]
        ),
    ]
)
