//
//  app.swift
//  SlimaneFullStack
//
//  Created by Yuki Takei on 6/21/16.
//
//

import SlimaneFullstack

func launchApp() {
    let app = Slimane()

    // Websocket server
    let wsServer = WebSocketServer { socket, request in
        socket.onText { text in
            switch text.lowercased() {
            case "ping":
                socket.send("PONG")
            default:
                print("Received: \(text)")
            }
        }
    }

    // JSON/FormData Body Parser
    app.use(BodyParser())

    // Static file serving
    app.use(Slimane.Static(root: "\(Process.cwd)/public"))

    // SessionConfig
    let sesConf = SessionConfig(
        secret: "my-secret-value",
        expires: 180,
        HTTPOnly: true
    )

    // Enable to use session in Slimane
    app.use(SessionMiddleware(conf: sesConf))

    // Upgrade to websocket
    app.use(wsServer)

    app.use { req, next, result in
        print("[pid:\(Process.pid)]\t\(Time())\t\(req.path ?? "/")")
        next.respond(to: req, result: result)
    }

    app.get("/") { req, responder in
        responder {
            Response(body: "Welcome to Slimane!")
        }
    }

    app.get("/websocket") { req, responder in
        responder {
            let render = Render(engine: MustacheViewEngine(templateData: ["websocketHost": "\(HOST):\(PORT)"]), path: "websocket")
            return Response(custom: render)
        }
    }

    // fibonacci with QWFuture and thrush
    app.get("/fibo") { req, responder in
        let promise = Promise<Int> { resolve, reject in
            func fibonacci(_ number: Int) -> (Int) {
                if number <= 1 {
                    return number
                } else {
                    return fibonacci(number - 1) + fibonacci(number - 2)
                }
            }

            let future = QWFuture<Int> { (completion: (() throws -> Int) -> ()) in
                completion {
                    fibonacci(10)
                }
            }

            future.onSuccess { result in
                resolve(result)
            }

            future.onFailure { error in
                reject(error)
            }
        }

        promise
          .then { result in
            responder {
                Response(body: "result is \(result)")
            }
          }
          .failure { error in
              responder {
                  Response(status: .internalServerError, body: "\(error)")
              }
          }
    }

    let text = "Slimane server is listening at \(HOST):\(PORT)"
    if Cluster.isMaster {
        print(text)
    } else {
        // Sending message to master process
        Process.send(.message(text))
    }

    try! app.listen(host: HOST, port: Int(PORT)!)
}
