// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let cOpenSSLRepo = "https://gitee.com/ztgtut/Perfect-COpenSSL-Linux"
#else
let cOpenSSLRepo = "https://gitee.com/ztgtut/Perfect-COpenSSL"
#endif

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
                        .package(name: "COpenSSL", url: cOpenSSLRepo, from: "4.0.2"),
                        .package(url: "https://gitee.com/ztgtut/SSNetwork.git", from: "1.0.0"),
                        .package(name: "swift-crypto", url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"),
                      ],
                      targets: [
                        .target(name: "SSCommon", path: "Sources/SSCommon"),
                        .target(name: "SSEncrypt", dependencies: [
                            "COpenSSL",
                            "SSCommon",
                            .product(name: "Crypto", package: "swift-crypto")
                        ], path: "Sources/SSEncrypt"),
                        .target(name: "SSLog", dependencies: [
                            "SSNetwork",
                            "SSCommon",
                        ], path: "Sources/SSLog"),
                      ])
