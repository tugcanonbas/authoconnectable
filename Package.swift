// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "{{name}}",
    platforms: [
       .macOS(.v12)
    ],
    dependencies:[ 
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-{{fluent.url}}-driver.git", from: "{{fluent.version}}"),{{#leaf}}
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),{{/leaf}}
        // 📦 ConnectableKit is a Swift package for the Vapor framework that simplifies the response DTOs and JSON structures for API projects.
        .package(url: "https://github.com/tugcanonbas/connectable-kit.git", from: "1.0.0"),
        // 📦 Authomatek is a pre-configured authentication for relational databases. It automates the process of creating all the necessary routes, controllers, and models, allowing you to quickly and easily set up authentication for your Vapor application.
        .package(url: "https://github.com/tugcanonbas/authomatek.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "Fluent{{fluent.module}}Driver", package: "fluent-{{fluent.url}}-driver"),{{#leaf}}
                .product(name: "Leaf", package: "leaf"),{{/leaf}}
                .product(name: "Vapor", package: "vapor"),
                .product(name: "ConnectableKit", package: "connectable-kit"),
                .product(name: "Authomatek", package: "authomatek"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
