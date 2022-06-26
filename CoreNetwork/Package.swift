// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetwork",
    products: [
        .library(
            name: "CoreNetwork",
            targets: [
                "CoreNetwork"
            ]
        ),
    ],
    targets: [
        .target(
            name: "CoreNetwork",
            dependencies: []
        ),
        .testTarget(
            name: "CoreNetworkTests",
            dependencies: [
                "CoreNetwork"
            ]
        ),
    ]
)
