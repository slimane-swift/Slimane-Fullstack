import PackageDescription

let package = Package(
    name: "SlimaneFullStack",
  	dependencies: [
      .Package(url: "https://github.com/noppoMan/Slimane.git", majorVersion: 0, minor: 6),
      .Package(url: "https://github.com/slimane-swift/BodyParser.git", majorVersion: 0, minor: 4),
      .Package(url: "https://github.com/slimane-swift/SessionMiddleware.git", majorVersion: 0, minor: 5),
      .Package(url: "https://github.com/slimane-swift/WS.git", majorVersion: 0, minor: 4)
   ],
   targets: [
       Target(
           name: "Example",
           dependencies: [
               .Target(name: "SlimaneFullStack")
           ]
       )
   ]
)
