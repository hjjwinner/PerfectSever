import PackageDescription

let package = Package(
    name: "MyAwesomeProject",
    dependencies: [
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
            majorVersion: 2, minor: 0),
        .Package(url:"https://github.com/PerfectlySoft/Perfect-Mustache.git", versions: Version(0,0,0)..<Version(10,0,0)
        )
    ]
)
