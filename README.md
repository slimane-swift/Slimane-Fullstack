# Slimane-Fullstack

FullStack Slimane that makes building web application faster.

## Available Functionalities

* [x] HTTP Server
* [ ] HTTP Client
* [ ] HTTPS Server
* [ ] HTTPS Client
* [x] Routing
* [x] Middleware
* [x] Session
* [x] Cookie
* [x] JSON
* [x] FormData
* [x] Redis
* [x] View/Template Engine
* [x] WebSocket
* [x] Cluster/Worker
* [x] Process
* [x] FileSystem
* [x] DNS
* [x] TCP/Pipe/UDP
* [x] Future/Promise
* [x] Timer
* [x] Hash
* [x] SecureRandom

## Getting Started

### Installation
First you need to setup your machine according to [Install Guide](https://github.com/noppoMan/Slimane/wiki/Install-Guide)

### Try Full Stack Example

### Build
```sh
git clone https://github.com/noppoMan/Slimane-Fullstack.git
cd Slimane-Fullstack
make debug
.build/debug/Example
```

### Launch Fullstack Example
```sh

# Single app
.build/debug/Example

## Cluster app
.build/debug/Example --cluster
```

## Start to create your application with Slimane

### 1. Create Package.swift

```sh
mkdir MySlimaneApp
cd MySlimaneApp
touch Package.swift
```
#### Open `Package.swift` with your preferred Editor and then add the following.
```swift
import PackageDescription

let package = Package(
	name: "MySlimaneApp",
	dependencies: [
      .Package(url: "https://github.com/noppoMan/Slimane-Fullstack.git", majorVersion: 0, minor: 1)
  ]
)
```

### 2. Create main.swift
```sh
mkdir Sources
touch main.swift
```

#### Open `main.swift` with your preferred Editor and then add the following.
```swift
import SlimaneFullStack

do {
  app.get("/") { req, responder in
      responder {
          Response(body: "Welcome to Slimane!")
      }
  }

  print("The server is listening at 0.0.0.0:3000")
  try app.listen()
} catch {
  print(error)
  // Should exit process
}
```

### 3. Build
```sh
wget https://raw.githubusercontent.com/noppoMan/Slimane-Fullstack/master/Makefile
make debug
```

### 4 Launch your App
```sh
$ .build/debug/MySlimaneApp
# The server is listening at 0.0.0.0:3000


$ curl http://localhost:3000/
# Welcome to Slimane!
```




## License

Slimane-Fullstack is released under the MIT license. See LICENSE for details.
