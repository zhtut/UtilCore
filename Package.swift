// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "SSCommon",
                      products: [
                        .library(name: "SSCommon", targets: ["SSCommon"]),
                      ],
                      dependencies: [
                      ],
                      targets: [
                        .target(name: "SSCommon"),
                        .testTarget(name: "SSCommonTests", dependencies: ["SSCommon"])
                      ])
