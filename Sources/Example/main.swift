import SlimaneFullStack

let PORT = Process.env["PORT"] ?? "3000"
let HOST = Process.env["HOST"] ?? "0.0.0.0"

if Process.arguments.count > 1 {
    let mode = Process.arguments[1]
    
    if mode == "--cluster" {
        func observeWorker(_ worker: inout Worker){
            worker.send(.message("message from master"))
            
            worker.on { event in
                if case .message(let str) = event {
                    print(str)
                }
                    
                else if case .online = event {
                    print("Worker: \(worker.id) is online")
                }
                    
                else if case .exit(let status) = event {
                    print("Worker: \(worker.id) is dead. status: \(status)")
                    worker = try! Cluster.fork(silent: false)
                    observeWorker(&worker)
                }
            }
        }
        
        // For Cluster app
        if Cluster.isMaster {
            print("Cluster mode is ready...")
            for _ in 0..<OS.cpuCount {
                var worker = try! Cluster.fork(silent: false)
                observeWorker(&worker)
            }
            
            try! Slimane().listen(port: Int(PORT)!)
        } else {
            launchApp()
        }
    }
} else {
    // for single thread app
    launchApp()
}