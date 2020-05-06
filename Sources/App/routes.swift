import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let countController = CountController()
    router.post("increment", use: countController.increment)
}
