import FluentSQLite
import Vapor

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    let host: String = "0.0.0.0"
    let port: Int = 8811
    let workers: Int = ProcessInfo.processInfo.activeProcessorCount * 2
    let serverConfig = NIOServerConfig.default(hostname: host,
                                               port: port,
                                               workerCount: workers)
    services.register(serverConfig)

    try services.register(FluentSQLiteProvider())

    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)

    let sqlite = try SQLiteDatabase(storage: .memory)

    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    var migrations = MigrationConfig()
    migrations.add(model: Count.self, database: .sqlite)
    services.register(migrations)
}
