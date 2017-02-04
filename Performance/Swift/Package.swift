import PackageDescription

let package = Package(
    name: "SwiftPerformance",
    dependencies: [
        .Package(url: "https://github.com/lgaches/MongoKitten.git", majorVersion: 3)
    ]
)
