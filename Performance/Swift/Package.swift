import PackageDescription

let package = Package(
    name: "SwiftPerformance",
    dependencies: [
        .Package(url: "https://github.com/OpenKitten/MongoKitten.git", "3.1.0-beta2")
    ]
)
