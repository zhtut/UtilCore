// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "SSCommon",
                      platforms: [
                        .iOS(.v13),
                        .macOS(.v10_15)],
                      products: [
                        .library(name: "SSCommon", targets: ["SSCommon"]),
                        .library(name: "SSEncrypt", targets: ["SSEncrypt"]),
                        .library(name: "SSLog", targets: ["SSLog"]),
                      ],
                      dependencies: [
                        .package(url: "https://github.com/zhtut/SSNetwork.git", from: "1.0.0"),
                        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"),
                      ],
                      targets: [
                        .target(name: "SSCommon", path: "Sources/SSCommon"),
                        .target(name: "SSEncrypt", dependencies: [
                            "SSCommon",
                            .product(name: "Crypto", package: "swift-crypto")
                        ], path: "Sources/SSEncrypt"),
                        .target(name: "SSLog", dependencies: [
                            "SSNetwork",
                            "SSCommon",
                        ], path: "Sources/SSLog"),
                      ])
