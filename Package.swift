// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WrapKitAuth",
    platforms: [ .macOS(.v10_14), .iOS(.v12) ],
    products: [
        .library(
            name: "WrapKitAuth",
            targets: ["WrapKitAuth"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/evgenyneu/keychain-swift.git",
            from: "20.0.0"
        ),
        .package(
            url: "https://github.com/gitlees/WrapKitNetworking.git",
            from: "0.0.2"
        )
    ],
    targets: [
        .target(
            name: "WrapKitAuth",
            dependencies: [
                .product(name: "KeychainSwift", package: "keychain-swift"),
                .product(name: "WrapKitNetworking", package: "WrapKitNetworking")
            ],
            path: "Sources/WrapKitAuth"),
        .testTarget(
            name: "WrapKitAuthTests",
            dependencies: ["WrapKitAuth"],
            path: "Tests/WrapKitAuthTests"),
    ]
)
