// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MacroStore",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "MacroStore",
            targets: ["MacroStore"]
        ),
        .executable(
            name: "MacroStoreClient",
            targets: ["MacroStoreClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", branch: "main"),
    ],
    targets: [
        .macro(
            name: "MacroStoreMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        .target(name: "MacroStore", dependencies: ["MacroStoreMacros"]),

        .executableTarget(name: "MacroStoreClient", dependencies: ["MacroStore"]),

        .testTarget(
            name: "MacroStoreTests",
            dependencies: [
                "MacroStoreMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
