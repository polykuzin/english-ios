// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EN_Summary",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "EN_Summary",
            targets: ["EN_Summary"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "EN_Summary",
            dependencies: []),
        .testTarget(
            name: "EN_SummaryTests",
            dependencies: ["EN_Summary"])
    ]
)
