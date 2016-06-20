import SlimaneFullStack

let app = Slimane()

let port = Process.env["PORT"] ?? "3000"
let host = Process.env["HOST"] ?? "0.0.0.0"

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


app.use { request, next, result in
    print(request.path ?? "/")
    next.respond(to: request, result: result)
}

app.get("/") { req, responder in
    responder {
        Response(body: "Welcome to Slimane!")
    }
}

print("Slimane server is listening at \(host):\(port)")
try! app.listen(host: host, port: Int(port)!)
