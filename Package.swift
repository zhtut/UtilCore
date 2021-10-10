// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let cOpenSSLRepo = "https://github.com/PerfectlySoft/Perfect-COpenSSL-Linux"
#else
let cOpenSSLRepo = "https://github.com/PerfectlySoft/Perfect-COpenSSL"
#endif

let package = Package(name: "SSCommon",
                      products: [
                        .library(name: "SSCommon", targets: ["SSCommon"]),
                        .library(name: "SSEncrypt", targets: ["SSEncrypt"]),
                        .library(name: "SSLog", targets: ["SSLog"]),
                      ],
                      dependencies: [
                        .package(name: "COpenSSL", url: cOpenSSLRepo, from: "4.0.2"),
                        .package(name: "SSNetwork", path: "../SSNetwork")
                      ],
                      targets: [
                        .target(name: "SSCommon", path: "Sources/SSCommon"),
                        .target(name: "SSEncrypt", dependencies: [
                            "COpenSSL",
                            "SSCommon",
                        ], path: "Sources/SSEncrypt"),
                        .target(name: "SSLog", dependencies: [
                            "SSNetwork",
                            "SSCommon",
                        ], path: "Sources/SSLog"),
                      ])
