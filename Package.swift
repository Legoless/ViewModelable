// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "ViewModelable",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "ViewModelable", targets: ["ViewModelable"]),
    ],
    targets: [
         .target(
            name: "ViewModelable",
            path: "ViewModelable",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
         )
    ]
)
