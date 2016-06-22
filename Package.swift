import PackageDescription

let package = Package(
    name: "SlimaneFullstack",
  	dependencies: [
      .Package(url: "https://github.com/noppoMan/Slimane.git", majorVersion: 0, minor: 6),
      .Package(url: "https://github.com/slimane-swift/BodyParser.git", majorVersion: 0, minor: 4),
      .Package(url: "https://github.com/slimane-swift/SessionRedisStore.git", majorVersion: 0, minor: 5),
      .Package(url: "https://github.com/slimane-swift/WS.git", majorVersion: 0, minor: 4),
      .Package(url: "https://github.com/slimane-swift/Render.git", majorVersion: 0, minor: 4),
      .Package(url: "https://github.com/slimane-swift/MustacheViewEngine.git", majorVersion: 0, minor: 5)
   ],
   exclude: ["public", "views", "Sources/Example"],
   targets: [
       Target(
           name: "Example",
           dependencies: [
               .Target(name: "SlimaneFullstack")
           ]
       )
   ]
)
