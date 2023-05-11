// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "UtilCore",
                      platforms: [
                        .macOS(.v10_15),
                        .iOS(.v13)
                      ],
                      products: [
                        .library(name: "UtilCore", targets: ["UtilCore"]),
                      ],
                      dependencies: [
                      ],
                      targets: [
                        .target(name: "UtilCore"),
                        .testTarget(name: "UtilCoreTests", dependencies: ["UtilCore"])
                      ])
