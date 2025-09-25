// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "erhuSoftUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "erhuSoftUI",
            targets: ["erhuSoftUI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "erhuSoftUI",
            dependencies: [],
            resources: [
                .process("Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "erhuSoftUITests",
            dependencies: ["erhuSoftUI"]
        ),
    ]
)
