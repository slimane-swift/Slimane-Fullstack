//
//  app.swift
//  SlimaneFullStack
//
//  Created by Yuki Takei on 6/21/16.
//
//

import SlimaneFullStack

func launchApp() {
    let app = Slimane()
    app.use(BodyParser())
    app.use(Slimane.Static(root: "\(Process.cwd)/public"))
    
    // SessionConfig
    let sesConf = SessionConfig(
        secret: "my-secret-value",
        expires: 180,
        HTTPOnly: true
    )
    
    // Enable to use session in Slimane
    app.use(SessionMiddleware(conf: sesConf))
    
    
    app.use { req, next, result in
        print("[pid:\(Process.pid)]\t\(Time())\t\(req.path ?? "/")")
        next.respond(to: req, result: result)
    }
    
    app.get("/") { req, responder in
        responder {
            Response(body: "Welcome to Slimane!")
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
