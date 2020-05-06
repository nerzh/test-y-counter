import Vapor
import FluentSQL

final class CountController {
    func increment(_ req: Request) throws -> Future<Int> {
        let url: String = try req.query.get(at: "url")
        guard url.count > 0 else { throw Abort(.badRequest, reason: "url can't be empty") }
        return Count.query(on: req).filter(\.url == url).first().flatMap { count -> Future<Count> in
            guard let count = count else {
                return Count(url: url).create(on: req)
            }
            count.count += 1
            return count.update(on: req)
        }.map { $0.count }
    }
}
