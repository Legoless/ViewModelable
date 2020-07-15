// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ViewModelable",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ViewModelable", targets: ["ViewModelable"]),
    ],
    targets: [
         .target(
            name: "ViewModelable",
            path: "ViewModelable"
         )
    ]
)
